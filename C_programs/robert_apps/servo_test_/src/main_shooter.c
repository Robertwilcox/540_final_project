#include <stdio.h>
#include <stdbool.h>
#include "joystick_wrapper.h"
#include "motor_control.h"
#include "servo_control.h"
#include "buttons.h"
#include "joystick_control.h"
#include "joystick_display.h"

#define DEBOUNCE_DELAY 90000  // Adjust this value as needed

void debounceDelay() {
    volatile int count = DEBOUNCE_DELAY;
    while (count--) {
        __asm__("nop"); // NOP for preventing loop optimization
    }
}

int main() {
   // enableSevSeg();
    bool motor_state = false;
    turnOffDCMotor();
    turnOnDCMotor();

    while (1) {
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
        else if (isButtonPressed2()) {
            debounceDelay();
            if (isButtonPressed2()) {  // Check the button state again after the delay
                if (!motor_state) {
                    turnOnDCMotor();
                    motor_state = true;
                } else {
                    turnOffDCMotor();
                    motor_state = false;
                }
            }
        }
    }

    return 0;
}
