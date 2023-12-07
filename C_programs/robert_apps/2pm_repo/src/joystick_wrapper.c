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
