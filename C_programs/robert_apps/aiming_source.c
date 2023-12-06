#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>

// Define the base address for the servo controller
#define SERVO_CTRL_BASE_ADDR 0x80001600

// Define the offset for the PWM width register
#define PWM_WIDTH_REG_OFFSET 0x04

// Define the address of the PWM width register
#define PWM_WIDTH_REG (SERVO_CTRL_BASE_ADDR + PWM_WIDTH_REG_OFFSET)
#define READ_PER(dir) (*(volatile unsigned *)dir)
#define WRITE_PER(dir, value) { (*(volatile unsigned *)dir) = (value); }

// Global control flag
volatile bool stopRequested = false;

void delay_loop(unsigned long loops) {
    for (unsigned long i = 0; i < loops; i++) {
        if (stopRequested) {
            break;
        }
        __asm__("nop"); // NOP for preventing loop optimization
    }
}

void move_CCW(uint32_t width_min, uint32_t width_max, unsigned long delay_per_step) {
    stopRequested = false; // Reset the stop flag
    uint32_t current_width = READ_PER(PWM_WIDTH_REG);

    while (current_width < width_max && !stopRequested) {
        current_width++;
        WRITE_PER(PWM_WIDTH_REG, current_width);
        delay_loop(delay_per_step);
    }
}

void move_CW(uint32_t width_min, uint32_t width_max, unsigned long delay_per_step) {
    stopRequested = false; // Reset the stop flag
    uint32_t current_width = READ_PER(PWM_WIDTH_REG);

    while (current_width > width_min && !stopRequested) {
        current_width--;
        WRITE_PER(PWM_WIDTH_REG, current_width);
        delay_loop(delay_per_step);
    }
}

void stop() {
    stopRequested = true;
}

int main() {
    // PWM width values for servo extremes and middle
    uint32_t width_min = 10000;  // Minimum PWM width
    uint32_t width_max = 30000; // Maximum PWM width

    // Total duration for half the oscillation in milliseconds
    unsigned long half_oscillation_duration_ms = 1000;

    // Number of steps for smooth transition
    unsigned int num_steps = 500;

    // Calculate delay per step in loop iterations (approximation)
    unsigned long delay_per_step = 500;

    while (1) {
        move_CW(width_min, width_max, delay_per_step);
        delay_loop(delay_per_step*100);
        move_CCW(width_min, width_max, delay_per_step);
        delay_loop(delay_per_step*100);
    }

    return 0; // This line will never be reached
}
