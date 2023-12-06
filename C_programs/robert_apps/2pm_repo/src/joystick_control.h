#ifndef JOYSTICK_CONTROL_H
#define JOYSTICK_CONTROL_H

unsigned int readJoystick();
void displayOn7Seg(unsigned int value);
unsigned int intTo7Seg(unsigned int value);
void enableSevSeg();
int HEX_TO_DEC(int hexValue);


#endif // JOYSTICK_CONTROL_H
