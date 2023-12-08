/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation joystick_control.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: C file for easily writing joysick
 * data to 7seg display
 */

// joystick_display.c
#include "joystick_display.h"
#include "servo_control.h"
#include <stdio.h>
#include <sys/_types.h>
#include "joystick_control.h"


void write_x_data() {
    unsigned int digits_reg = 0x0;
    unsigned int x_data = readJoystick();
    digits_reg = HEX_TO_DEC(x_data);
    // Display x_data on the 7-segment display
    displayOn7Seg(digits_reg);
}
