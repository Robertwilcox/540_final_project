/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Header switch.h
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The switch wrapper file. Involves reading from the GPIO0 IN
 * register, writing to the GPIO0 OUT register, and initializes the GPIO0 OE
 * register.
 * 
 */

#ifndef __SWITCH_H
#define __SWITCH_H

#include <stdint.h>

// GPIO0 Module Registers
#define RGPIO0_IN       0x80001400
#define RGPIO0_OUT      0x80001404
#define RGPIO0_OE       0x80001408

#define RD_GPIO(dir) (*(volatile unsigned *)dir)
#define WR_GPIO(dir, val) { (*(volatile unsigned *)dir) = (val); }

// switch_init(val):
//
// Configure the GPIOs in GPIO0 OE register with the following val 
// as output or HI-Z for input.
//
void switch_init(uint32_t val);

// switch_read(void):
//
// Read from GPIO0 IN register and return that unsigned 32 bit value.
//
uint32_t switch_read(void);

// switch_write(val):
//
// Write to GPIO0 OUT register with the following val.
//
void switch_write(uint32_t val);

#endif // __SWITCH_H