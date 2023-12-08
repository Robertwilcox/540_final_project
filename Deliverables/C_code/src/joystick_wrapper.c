/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation joystick_control.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: Wrapper for joystick file which
 * allows for easier reading of data. Simple functions
 * for which way the joystick is pointing
 * 
 */
#include "joystick_control.h"
#include <stdbool.h>

bool isJoystickLeft() {
    unsigned int x_data = readJoystick();
    return x_data < 400;
}

bool isJoystickRight() {
    unsigned int x_data = readJoystick();
    return x_data > 623;
}

bool isJoystickMiddle() {
    unsigned int x_data = readJoystick();
    return x_data >= 400 && x_data <= 623;
}
