/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation hc_sr04.c
 * 12/03/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The HC-SR04 sensor wrapper file. Involves reading from the PMOD D
 * peripheral register. At the offset 0x0000_1600 + the base address of 0x8000_0000.
 * The following functions allow the ease of retrieving the status and echo_pulse bits.
 * Also, there is a functions that wraps around the ee_printf() function to print out
 * to the serial terminal the status and echo_pulse values.
 *
 */

#include "hc_sr04.h"
#include <stdbool.h>

// get_echo_pulse(void):
//
// IF an echo pulse has been recieved, returns 1. 
// ELSE returns 0.
//
uint8_t get_echo_pulse(void) {
    return (RD_GPIO(PMODD_STATE) & (0x00000001));
}

// get_status(void):
//
// IF an true echo pulse was detected, returns 0.
// ELSE returns 2.
//
bool get_status(void) {
    if ((RD_GPIO(PMODD_STATE) & (0x00000002)) == 0)
        return true;
    else
        return false;
}

// hc_sr04_debug(void):
//
// Prints out to the serial terminal the status and echo pulse from HC-SR04
// sensor. 
//
// Note: Requires config_uart() to be called in main() routine.
//
void hc_sr04_debug(void) {
    ee_printf("DEBUG: HC-SR04::status = %d,  HC-SR04::echo = %d\n", 
            RD_GPIO(PMODD_STATE) & (0x00000002), RD_GPIO(PMODD_STATE) & (0x00000001));
}
