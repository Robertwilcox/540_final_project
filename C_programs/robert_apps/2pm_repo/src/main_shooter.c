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
    for (int i = DEBOUNCE_DELAY; i > 0; i--){}

    int score = 0;  // Initialize the score

    int bttn[4] = {0};
    int switch_val, led_val;
    int temp_val0;
    int prev_state_i[10];
    int prev_state_f;
    int curr_state, echo;

    bttn_init(0x0);
    while (1) {

        
        temp_val0    = bttn_read();
    
    //    switch_val   = switch_read();
      //  led_val      = switch_val >> 16;

        //switch_write(led_val);
      
        //state     = get_status();
        //echo      = get_echo_pulse();

        bttn[0] = temp_val0 & (0x00000001); // Mask BTN[0]
        bttn[1] = temp_val0 & (0x00000002); // Mask BTN[1]  
        bttn[2] = temp_val0 & (0x00000004); // Mask BTN[2]  
        bttn[3] = temp_val0 & (0x00000008); // Mask BTN[3]  

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
        if (bttn[0]) {
            debounceDelay();
            if (bttn[0]) {  // Check the button state again after the delay
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
        prev_state_i[0] = get_status();
        echo = get_echo_pulse();
        
        prev_state_i[1] = get_status();
        prev_state_i[2] = get_status();
        prev_state_i[3] = get_status();
        prev_state_i[4] = get_status();
        prev_state_i[5] = get_status();
        prev_state_i[6] = get_status();
        prev_state_i[7] = get_status();
        prev_state_i[8] = get_status();
        prev_state_i[9] = get_status();

        curr_state = get_status() ? 0 : 1;

        for (int i = 0; i < 10; i++) {
            prev_state_f = prev_state_i[i] ? 1 : 0;
            for (int i = DEBOUNCE_DELAY; i>0; i--){}
        }

        if ((!curr_state) && (prev_state_f)) {
            score++;  // Increment score if sensor detects something
            vga_display_hit();  // Display "Hit" message
        } else {
            vga_display_score(score);  // Display "Miss" message
        }

        // Display the score on the VGA
        vga_display_score(score);
    }

    return 0;
}
