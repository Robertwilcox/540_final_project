/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation ssegment.c
 * 12/04/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The 7 segment display wrapper file. Initializes the 7 segment
 * displays to certain digits to on the 8 digit 7 segement displays. Provides a
 * function to write data to the displays and global variables to be used in
 * the main() routine for desired game state.
 * 
 */

#include "ssegment.h"

// Global Variables
uint8_t game_state;
uint32_t on_off_state;

// sseg_init(non_active):
//
// Configures the 7 segments to allow certain segments to be ON/OFF. Also
// Writes the ON/OFF state of the game interactive basketball. Initialize the
// on_off_state global variable before calling sseg_init() in main() routine.
//
void sseg_init(uint8_t non_active) {
    WR_GPIO(SYSCON_EN, non_active);

    // IF game state is ON
    if (game_state) {
        WR_GPIO(SYSCON_DGT, on_off_state);
    }
    // ELSE OFF state
    else {
        WR_GPIO(SYSCON_DGT, on_off_state);
    }   
}

// sseg_write(data):
//
// Writes the data to the 7 segment displays. Use the OR bitwise operator along
// with the on_off_state to show the game state currently. Requires
// on_off_state to be initialized before calling sseg_write() in main() routine.
//
void sseg_write(uint32_t data) {
    WR_GPIO(SYSCON_DGT, data);
}
