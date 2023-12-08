#include "motor_control.h"

// Define the base address for the DC motor controller
#define DC_CTRL_BASE_ADDR 0x80001704

// Define write operation macro
#define READ_PER(dir) (*(volatile unsigned *)dir)
#define WRITE_PER(dir, value) { (*(volatile unsigned *)dir) = (value); }

// Function to turn the DC motor on
void turnOnDCMotor() {
    WRITE_PER(DC_CTRL_BASE_ADDR, 0); // Write '0' to the DC control register to turn it on
}

// Function to turn the DC motor off
void turnOffDCMotor() {
    WRITE_PER(DC_CTRL_BASE_ADDR, 100); // Write '1' to the DC control register to turn it off
}
