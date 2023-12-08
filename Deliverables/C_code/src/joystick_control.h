/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation joystick_control.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: Wrapper for joystick_control, which has
 * functions for reading joystick data, converting from hex to dec,
 * and enabling and displaying joystick
 * data on 7Segment display
 * 
 */
#ifndef JOYSTICK_CONTROL_H
#define JOYSTICK_CONTROL_H

unsigned int readJoystick();
void displayOn7Seg(unsigned int value);
unsigned int intTo7Seg(unsigned int value);
void enableSevSeg();
int HEX_TO_DEC(int hexValue);


#endif // JOYSTICK_CONTROL_H
