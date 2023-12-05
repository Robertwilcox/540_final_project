/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation bttn.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The button wrapper file. Involves reading from the GPIO1 IN
 * register, writing to the GPIO1 OUT register, and initializes the GPIO1 OE
 * register.
 * 
 */

#include "bttn.h"


// bttn_init(val):
//
// Configure the GPIOs in GPIO1 OE register with the following val 
// as output or HI-Z for input.
//
void bttn_init(uint32_t val) {
    WR_GPIO(RGPIO1_OE, val);
}


// bttn_read(void):
//
// Read from GPIO1 IN register and return that unsigned 32 bit value.
//
uint32_t bttn_read(void) {
    return RD_GPIO(RGPIO1_IN);
}

// bttn_write(val):
//
// Write to GPIO1 OUT register with the following val.
//
void bttn_write(uint32_t val) {
    WR_GPIO(RGPIO1_OUT, val);
}