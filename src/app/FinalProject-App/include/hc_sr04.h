/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Header hc_sr04.h
 * 12/05/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The HC-SR04 sensor wrapper file. Involves reading from the PMOD D
 * peripheral register. At the offset 0x0000_1640 + the base address of 0x8000_0000.
 * The following functions allow the ease of retrieving the status and echo_pulse bits.
 * Also, there is a functions that wraps around the ee_printf() function to print out
 * to the serial terminal the status and echo_pulse values.
 * 
 */
#ifndef __HC_SR04_H
#define __HC_SR04_H
#include <stdio.h>
#include <string.h>
#include <stdint.h>

#ifdef NO_SEMIHOSTING
#include "ee_printf.h"
#ifdef CUSTOM_UART
#include <uart.h>
#endif // CUSTOM_UART
#endif // NO_SEMIHOSTING

// PMOD D Module Register
#define PMODD_STATE     0x80001640

#define RD_GPIO(dir) (*(volatile unsigned *)dir)

// get_echo_pulse(void):
//
// IF an echo pulse has been recieved, returns 1. 
// ELSE returns 0.
//
uint8_t get_echo_pulse(void);

// get_status(void):
//
// IF an true echo pulse was detected, returns 0.
// ELSE returns 2.
//
uint8_t get_status(void);

// hc_sr04_debug(void):
//
// Prints out to the serial terminal the status and echo pulse from HC-SR04
// sensor. 
//
// Note: Requires config_uart() to be called in main() routine.
//
void    hc_sr04_debug(void);

#endif // __HC_SR04_H
