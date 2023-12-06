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


#define DEBOUNCE_DELAY 90000  // Adjust this value as needed

void debounceDelay() {
    volatile int count = DEBOUNCE_DELAY;
    while (count--) {
        __asm__("nop"); // NOP for preventing loop optimization
    }
}

int main() {
    bool motor_state = false;
    turnOffDCMotor();
    vga_display_welcome();

    int score = 0;  // Initialize the score

    int bttn[4] = {0};
    int switch_val, led_val;
    int temp_val0;
    int state, echo;

    if(!get_status()) {
        turnOnDCMotor();
    }

    while (1) {

        /*
        temp_val0    = bttn_read();
        switch_val   = switch_read();
        led_val      = switch_val >> 16;

        switch_write(led_val);
      
        state     = get_status();
        echo      = get_echo_pulse();

        bttn[0] = temp_val0 & (0x00000001); // Mask BTN[0]
        bttn[1] = temp_val0 & (0x00000002); // Mask BTN[1]  
        bttn[2] = temp_val0 & (0x00000004); // Mask BTN[2]  
        bttn[3] = temp_val0 & (0x00000008); // Mask BTN[3]  
    */

        if (isJoystickLeft()) {
            servoMoveCCW();
            write_x_data();
        } 
        else if (isJoystickRight()) {
            servoMoveCW();
            write_x_data();
        } 
        else if (isJoystickMiddle()) {
            servoStop();
            write_x_data();
        } 
        else if (isButtonPressed0()) {
            debounceDelay();
            if (isButtonPressed0()) {  // Check the button state again after the delay
                if (!motor_state) {
                    turnOnDCMotor();
                    motor_state = true;
                } else {
                    turnOffDCMotor();
                    motor_state = false;
                }
            }
        }
        
        // Sensor detection and score update
        state = get_status();
        echo = get_echo_pulse();

        if (echo) {
            score++;  // Increment score if sensor detects something
            vga_display_hit();  // Display "Hit" message
        } else {
            vga_display_miss();  // Display "Miss" message
        }

        // Display the score on the VGA
        vga_display_score(score);
    }

    return 0;
}
