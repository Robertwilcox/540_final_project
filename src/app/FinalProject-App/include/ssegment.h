/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Header ssegment.h
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The 7 segment display wrapper file. Initializes the 7 segment
 * displays to certain digits to on the 8 digit 7 segement displays. Provides a
 * function to write data to the displays and global variables to be used in
 * the main() routine for desired game state.
 * 
 */

#ifndef __SSEG_H
#define __SSEG_H

#include <stdint.h>

// SYSCON Module Register
#define SYSCON_BASE     0x80001000
#define SYSCON_EN       0x80001038
#define SYSCON_DGT      0x8000103C

#define OFF_STATE       (0 << 28) | (0xF << 24) | (0xF << 20)   // 0FF -0000
#define ON_STATE        (0 << 28) | (0 << 24) | (1 << 20)       // 001 -0000

#define WR_GPIO(dir, val) { (*(volatile unsigned *)dir) = (val); }

// sseg_init(non_active):
//
// Configures the 7 segments to allow certain segments to be ON/OFF. Also
// Writes the ON/OFF state of the game interactive basketball. Initialize the
// on_off_state global variable before calling sseg_init() in main() routine.
//
void sseg_init(uint8_t non_active);

// sseg_write(data):
//
// Writes the data to the 7 segment displays. Use the OR bitwise operator along
// with the on_off_state to show the game state currently. Requires
// on_off_state to be initialized before calling sseg_write() in main() routine.
//
void sseg_write(uint32_t data);

#endif // __SSEG_H
