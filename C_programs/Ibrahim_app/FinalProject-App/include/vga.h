/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Header vga.h
 * 12/03/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The VGA display wrapper file. The VGA peripheral has certain
 * characters programmed into a ROM. This wrapper file writes to the VGACON_DATA 
 * register a ASCII character hex value. The initial coordinates (x,y) are chosen
 * to present or move characters around the 640x480px screen.
 *
 */

#ifndef __VGA_H
#define __VGA_H

#include <stdio.h>
#include <string.h>
#ifdef NO_SEMIHOSTING
#include "ee_printf.h"
#ifdef CUSTOM_UART
#include <uart.h>
#endif // CUSTOM_UART
#endif // NO_SEMIHOSTING

// VGACON Module Registers
#define VGACON_XYCNTR   0x80001500
#define VGACON_ROWCOL   0x80001504
#define VGACON_PIXCNTR  0x80001508
#define VGACON_DATA     0x8000150C

#define DISPLAY_DELAY   40000

#define MAX_ROW      480
#define MAX_COL      640

#define RD_GPIO(dir) (*(volatile unsigned *)dir)
#define WR_GPIO(dir, val) { (*(volatile unsigned *)dir) = (val); }

// vga_display_welcome():
//
// Writes to the screen 'welcome'.
//
void vga_display_welcome(void);

// vga_display_miss():
//
// Writes to the screen a miss message.
//
void vga_display_miss(void);

// vga_display_hit():
//
// Writes to the screen a hit message.
//
void vga_display_hit(void);

// vga_display_score(val):
//
// Writes to the screen the current score.
//
void vga_display_score(int _val);

// _str2ascii(row, col, string):
//
// Writes the characters found in the string from left to right. With respect
// to the cordinates of the row and col.
//
void _str2ascii(int _row, int _col, char *string);

// _vga_delay():
//
// Delays the vga character written enough to see the whole string of characters
//
void _vga_delay(void);

#endif // __VGA_H
