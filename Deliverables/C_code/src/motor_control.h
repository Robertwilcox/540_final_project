/**
 motor_control.h
 *
 * @author      Robert Wilcox (wilcox6@pdx.edu)
 * @date        7-Dec-2023
 *
 * Implements motor_control.c, which controlls
 * a DC motor via pwm (motor must be hooked up
 * to viable circuitry). Currently only on or 
 * off functions.
 */

#ifndef MOTOR_CONTROL_H
#define MOTOR_CONTROL_H

#include <stdint.h>

// Function prototypes
void turnOnDCMotor();
void turnOffDCMotor();

#endif // MOTOR_CONTROL_H
