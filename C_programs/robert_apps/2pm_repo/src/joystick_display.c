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
