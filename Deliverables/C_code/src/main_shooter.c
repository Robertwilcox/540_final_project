#include <stdio.h>
#include <stdbool.h>
#include "joystick_wrapper.h"
#include "motor_control.h"
#include "servo_control.h"
#include "buttons.h"
#include "joystick_control.h"
#include "joystick_display.h"
#include "vga.h"
#include "hc_sr04.h"
#include "switch.h"
#include "bttn.h"

// Define a delay for button debounce
#define DEBOUNCE_DELAY 90000

// Function to introduce a delay, used for debouncing buttons
void debounceDelay() {
    volatile int count = DEBOUNCE_DELAY;

    // A loop that does nothing (NOP) for the duration of DEBOUNCE_DELAY
    while (count--) {
        __asm__("nop"); // Assembly instruction for No Operation (NOP)
    }
}

int main() {

    // Initialize motor state to false (off)
    bool motor_state = false;

    // Turn off the DC motor initially
    turnOffDCMotor();

    // Display a welcome message on the VGA display
    vga_display_welcome();

    // Initial delay to stabilize the system after power-up
    for (int i = DEBOUNCE_DELAY; i > 0; i--){}

    // Initialize score variable for tracking game score
    int score = 0;

    // Array to store button states
    int bttn[4] = {0};

    // Variables for storing switch, LED, and temporary values
    int switch_val, led_val;
    int temp_val0;

    // Arrays to store previous state of sensor inputs
    int prev_state_i[10];

    // Final calculated previous state
    int prev_state_f;

    // Current state and echo variable for sensor
    int curr_state, echo;

    // Initialize button inputs
    bttn_init(0x0);
    while (1) {

        // Read button states
        temp_val0 = bttn_read();

        // Mask each button state from the read value
        bttn[0] = temp_val0 & (0x00000001); // Mask BTN[0]
        bttn[1] = temp_val0 & (0x00000002); // Mask BTN[1]  
        bttn[2] = temp_val0 & (0x00000004); // Mask BTN[2]  
        bttn[3] = temp_val0 & (0x00000008); // Mask BTN[3]  

        // Check joystick directions and perform actions
        if (isJoystickLeft()) {
            servoMoveCCW(); // Move servo counter-clockwise
            write_x_data(); // Log data
        } 
        else if (isJoystickRight()) {
            servoMoveCW(); // Move servo clockwise
            write_x_data(); // Log data
        } 
        else if (isJoystickMiddle()) {
            servoStop(); // Stop servo
            write_x_data(); // Log data
        } 
        // Check button 0 state for DC motor control
        if (bttn[0]) {
            debounceDelay(); // Debounce button press
            if (bttn[0]) {  // Recheck button state after debounce
                // Toggle motor state
                if (!motor_state) {
                    turnOnDCMotor();
                    motor_state = true;
                } else {
                    turnOffDCMotor();
                    motor_state = false;
                }
            }
        }
        
        // Sensor detection and score updating logic
        for (int i = 0; i < 10; i++) {
            prev_state_i[i] = get_status();             // Store consecutive sensor states
            for (int j = DEBOUNCE_DELAY; j>0; j--){}
        }
        curr_state = get_status() ? 0 : 1;              // Determine current state

        // Compare current and previous sensor states to update score
        if ((!curr_state) && (prev_state_f)) {
            score++;                                    // Increment score on sensor trigger
            vga_display_hit();                          // Display hit message on VGA
        } else {
            vga_display_score(score);                   // Display score on VGA
        }
    }

    return 0;
}
