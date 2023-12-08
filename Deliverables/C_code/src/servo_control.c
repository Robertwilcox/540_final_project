

/**
 servo_control.c
 *
 * @author      Robert Wilcox (wilcox6@pdx.edu)
 * @date        7-Dec-2023
 *
 * Implements PWM controller on the FPGA to control
 * servo motor. Servo control has 3 functions, which
 * move the servo either direction or stop it. Within
 * the functions there is a check to see if the 
 * joystick is in the middle and stop movement if so
 */

#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include "motor_control.h"
#include "buttons.h"
#include "joystick_wrapper.h"

// Define the base address for the servo controller
#define SERVO_CTRL_BASE_ADDR 0x80001600

// Define the offset for the PWM width register
#define PWM_WIDTH_REG_OFFSET 0x04

// Define the address of the PWM width register
#define PWM_WIDTH_REG (SERVO_CTRL_BASE_ADDR + PWM_WIDTH_REG_OFFSET)
#define READ_PER(dir) (*(volatile unsigned *)dir)
#define WRITE_PER(dir, value) { (*(volatile unsigned *)dir) = (value); }

// PWM width values for servo extremes and middle
#define WIDTH_MIN 10000  // Minimum PWM width
#define WIDTH_MAX 30000  // Maximum PWM width
#define DELAY_PER_STEP 500

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

void servoMoveCCW() {
    stopRequested = false;
    uint32_t current_width = READ_PER(PWM_WIDTH_REG);

    while (current_width < WIDTH_MAX && !stopRequested) {
        if (isJoystickMiddle()) {
            break;  // Break out of the loop if button 2 is pressed
        }
        current_width++;
        WRITE_PER(PWM_WIDTH_REG, current_width);
        delay_loop(DELAY_PER_STEP);
    }
}

void servoMoveCW() {
    stopRequested = false;
    uint32_t current_width = READ_PER(PWM_WIDTH_REG);

    while (current_width > WIDTH_MIN && !stopRequested) {
        if (isJoystickMiddle()) {
            break;  // Break out of the loop if button 2 is pressed
        }
        current_width--;
        WRITE_PER(PWM_WIDTH_REG, current_width);
        delay_loop(DELAY_PER_STEP);
    }
}


void servoStop() {
    stopRequested = true;
}
