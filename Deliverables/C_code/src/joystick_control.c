/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation joystick_control.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: Functions for reading 
 * joystick data, converting from hex to dec,
 * and enabling and displaying joystick
 * data on 7Segment display
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/_types.h>
#include "servo_control.h"
#include "motor_control.h"

// Joystick Control Registers
#define JSTK_CTRL_REG                      0x80001900 // 0000 0000_##

// Seven Segment display registers
#define SEVEN_SEG_DISPLAY_EN_REG_0          0x80001038
#define SEVEN_SEG_DISPLAY_Digits_REG        0x8000103C

// Control on Board 
#define GPIO_SWs        0x80001400
#define GPIO_LEDs       0x80001404
#define GPIO_SW_INOUT   0x80001408

#define GPIO_Buttons    0x80001800
#define GPIO_BT_INOUT   0x80001808

// Read & Write functions 
#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

// Convert from HEX to Decimal function
int HEX_TO_DEC(int hexValue) {
    int decimalValue = 0;
    int base = 1;

    while (hexValue > 0) {
        int remainder = hexValue % 10;
        decimalValue += remainder * base;
        base *= 16;
        hexValue /= 10;
    }

    return decimalValue;
}


void displayOn7Seg(unsigned int value) {
    WRITE_GPIO(SEVEN_SEG_DISPLAY_Digits_REG, value);
}

void enableSevSeg() {
    WRITE_GPIO(SEVEN_SEG_DISPLAY_EN_REG_0, 0xFFFF); // Assuming 0xFFFF enables the display
}

// Funciton to read joystick
unsigned int readJoystick() {
    unsigned int xy_data = READ_GPIO(JSTK_CTRL_REG); // Read Joystick
    unsigned int x_data = (xy_data & 0x3) << 8; // upper two bits
    x_data = x_data | ((xy_data >> 8) & 0xFF); // lower 8 bits
    return x_data;
}

/*int main(void) {
    turnOffDCMotor();
    int En_SW_Value=0xFFFF; //enable value
    unsigned int Digits_Reg = 0x0; // For the 7-seg displays

    unsigned int xy_data; //Switches data 
    unsigned int x_data;
    while(1) {
        xy_data = READ_GPIO(JSTK_CTRL_REG); // Read Joystick
        x_data = (xy_data & 0x3) << 8; // upper two bits
        x_data = x_data | ((xy_data >> 8) & 0xFF); // lower 8 bits

        if (x_data < 400) {
            printf("Left at: %c", x_data);
        } else if (x_data > 623) {
            printf("Right at: %c", x_data);
        } else {
            printf("Middle at: %c", x_data);
        }

        Digits_Reg = HEX_TO_DEC(x_data);
        // Write to 7-seg displays
        WRITE_GPIO(SEVEN_SEG_DISPLAY_Digits_REG, Digits_Reg);
        WRITE_GPIO(GPIO_SW_INOUT, En_SW_Value); // Enable Switches register    
    }   
    return(0);
}*/