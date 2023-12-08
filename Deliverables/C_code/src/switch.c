/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation switch.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The switch wrapper file. Involves reading from the GPIO0 IN
 * register, writing to the GPIO0 OUT register, and initializes the GPIO0 OE
 * register.
 * 
 */

#include "switch.h"

// switch_init(val):
//
// Configure the GPIOs in GPIO0 OE register with the following val 
// as output or HI-Z for input.
//
void switch_init(uint32_t val) {
    WR_GPIO(RGPIO0_OE, val);
}

// switch_read(void):
//
// Read from GPIO0 IN register and return that unsigned 32 bit value.
//
uint32_t switch_read(void) {
    return RD_GPIO(RGPIO0_IN);
}

// switch_write(val):
//
// Write to GPIO0 OUT register with the following val.
//
void switch_write(uint32_t val) {
    WR_GPIO(RGPIO0_OUT, val);
}