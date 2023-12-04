/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Implementation vga.c
 * 12/03/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: The VGA display wrapper file. The VGA peripheral has certain
 * characters programmed into a ROM. This wrapper file writes to the VGACON_DATA 
 * register a ASCII character hex value. The initial coordinates (x,y) are chosen
 * to present or move characters around the 640x480px screen.
 *
 */

#include "vga.h"

// The following array contains the addresses to numbers and letters char's 
// index [0-9] 		=> {0, 1, 2, ..., 9}
// index [10-35]	=> {a, b, c, ..., z}
// index [36-39]	=> { space, !, ", #}
unsigned int ascii_char[40] = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
                            0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A,
                            0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73, 0x74,
                            0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x20, 0x21, 0x22, 0x23};

int row, col, init_row_col;

// vga_display_welcome():
//
// Writes to the screen 'welcome'.
//
void vga_display_welcome(void) {
    row = 240;
    col = 300;

    _str2ascii(row, col, "welcome!");
}

// vga_display_miss(val):
//
// Writes to the screen if a miss happened along with the score.
//
void vga_display_miss(int _val) {
    row = 240;
    col = 300;

    _str2ascii(row, col, "miss!");

    row = 240;
    col = 306;
    char num_val[2] = {_val + '0', '\0'};
    _str2ascii(row, col, "score ");

    col = 312;
    _str2ascii(row, col, num_val);
}

// vga_display_hit(val):
//
// Writes to the screen if a hit happened along with the score.
//
void vga_display_hit(int _val) {
    row = 240;
    col = 300;

    _str2ascii(row, col, "hit!");
    char num_val[2] = {_val + '0', '\0'};
    
    row = 240;
    col = 306;
    _str2ascii(row, col, "score ");

    col = 312;

    _str2ascii(row, col, num_val);
}

// _str2ascii(row, col, string):
//
// Writes the characters found in the string from left to right. With respect
// to the cordinates of the row and col.
//
void _str2ascii(int _row, int _col, char *string) {
    int i = 0;
    while (string[i] != '\0') {
        init_row_col = 0x0 | _row << 10 | _col;

        switch (string[i]) {
            // 0
            case 0x30:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[0]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 1
            case 0x31:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[1]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 2
            case 0x32:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[2]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 3
            case 0x33:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[3]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 4
            case 0x34:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[4]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 5
            case 0x35:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[5]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 6
            case 0x36:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[6]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 7
            case 0x37:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[7]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 8
            case 0x38:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[8]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // 9
            case 0x39:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[9]);
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // a
            case 0x61:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[10]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // b
            case 0x62:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[11]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // c
            case 0x63:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[12]);  
                _vga_delay();  
                i++;  
                _col += 8;
                break;
            // d
            case 0x64:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[13]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // e
            case 0x65:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[14]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // f
            case 0x66:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[15]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // g
            case 0x67:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[16]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // h
            case 0x68:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[17]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // i
            case 0x69:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[18]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // j
            case 0x6A:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[19]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // k
            case 0x6B:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[20]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // l
            case 0x6C:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[21]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // m
            case 0x6D:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[22]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // n
            case 0x6E:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[23]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // o
            case 0x6F:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[24]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // p
            case 0x70:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[25]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // q
            case 0x71:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[26]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // r
            case 0x72:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[27]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // s
            case 0x73:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[28]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // t
            case 0x74:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[29]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // u
            case 0x75:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[30]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // v
            case 0x76:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[31]);  
                _vga_delay();  
                i++;  
                _col += 8;
                break;
            // w
            case 0x77:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[32]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // x
            case 0x78:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[33]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // y
            case 0x79:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[34]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // z
            case 0x7A:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[35]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // space
            case 0x20:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[36]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // !
            case 0x21:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[37]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // "
            case 0x22:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[38]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
            // #
            case 0x23:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[39]);  
                _vga_delay();
                i++;  
                _col += 8;
                break;
        }
    }
}

// _vga_delay():
//
// Delays the vga character written enough to see the whole string of characters
//
void _vga_delay(void) {
    for (int i = DISPLAY_DELAY; i > 0; i--) {}
}