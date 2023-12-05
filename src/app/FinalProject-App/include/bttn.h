/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Header bttn.h
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The button wrapper file. Involves reading from the GPIO1 IN
 * register, writing to the GPIO1 OUT register, and initializes the GPIO1 OE
 * register.
 * 
 */

#ifndef __BTTN_H
#define __BTTN_H

#include <stdint.h>

// GPIO1 Module Registers
#define RGPIO1_IN       0x80001800
#define RGPIO1_OUT      0x80001804
#define RGPIO1_OE       0x80001808

#define RD_GPIO(dir) (*(volatile unsigned *)dir)
#define WR_GPIO(dir, val) { (*(volatile unsigned *)dir) = (val); }

// bttn_init(val):
//
// Configure the GPIOs in GPIO1 OE register with the following val 
// as output or HI-Z for input.
//
void bttn_init(uint32_t val);

// bttn_read(void):
//
// Read from GPIO1 IN register and return that unsigned 32 bit value.
//
uint32_t bttn_read(void);

// bttn_write(val):
//
// Write to GPIO1 OUT register with the following val.
//
void bttn_write(uint32_t val);

#endif // __BTTN_H