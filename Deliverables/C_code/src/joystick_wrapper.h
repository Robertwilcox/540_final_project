/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation joystick_control.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: header for joystick wrapper file which
 * allows for easier reading of data. Simple functions
 * for which way the joystick is pointing
 * 
 */
#ifndef JOYSTICK_WRAPPER_H
#define JOYSTICK_WRAPPER_H

#include <stdbool.h>

bool isJoystickLeft();
bool isJoystickRight();
bool isJoystickMiddle();

#endif // JOYSTICK_WRAPPER_H
