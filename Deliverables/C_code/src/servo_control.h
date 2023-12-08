/**
 servo_control.h
 *
 * @author      Robert Wilcox (wilcox6@pdx.edu)
 * @date        7-Dec-2023
 *
 * Servo control has 3 functions, which
 * move the servo either direction or stop it. Within
 * the functions there is a check to see if the 
 * joystick is in the middle and stop movement if so
 */
#ifndef SERVO_CONTROL_H
#define SERVO_CONTROL_H

#include <stdint.h>

void servoMoveCW();
void servoMoveCCW();
void servoStop();

#endif // SERVO_CONTROL_H
