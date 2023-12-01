/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Application app.c
 * 11/25/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: 
 *
 */


#include <stdio.h>
#include <string.h>
#ifdef NO_SEMIHOSTING
#include "ee_printf.h"
#ifdef CUSTOM_UART
#include <uart.h>
#endif // CUSTOM_UART
#endif // NO_SEMIHOSTING

// GPIO0 Module Registers
#define RGPIO0_IN       0x80001400
#define RGPIO0_OUT      0x80001404
#define RGPIO0_OE       0x80001408

// GPIO1 Module Registers
#define RGPIO1_IN       0x80001800
#define RGPIO1_OUT      0x80001804
#define RGPIO1_OE       0x80001808

// SYSCON Module Register
#define SYSCON_BASE     0x80001000
#define SYSCON_EN       0x80001038
#define SYSCON_DGT      0x8000103C

// VGACON Module Registers
#define VGACON_XYCNTR   0x80001500
#define VGACON_ROWCOL   0x80001504
#define VGACON_PIXCNTR  0x80001508
#define VGACON_DATA     0x8000150C

// PMOD D Module Registers
#define PMODD_STATE     0x80001600

#define ALL_LEDS        0x0000FFFF
#define WAIT_DELAY      1000000

#define MAX_ROW      480
#define MAX_COL      640

#define RD_GPIO(dir) (*(volatile unsigned *)dir)
#define WR_GPIO(dir, val) { (*(volatile unsigned *)dir) = (val); }

void str2ascii(int _row, int _col, char *string);
void vga_display_welcome(void);
void vga_display_miss(int _val);
void vga_display_hit(int _val);
void delay(void);

// The following array contains the addresses to numbers and letters char's 
// index [0-9] 		=> {0, 1, 2, ..., 9}
// index [10-35]	=> {a, b, c, ..., z}
// index [36-39]	=> { space, !, ", #}
unsigned int ascii_char[40] = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
                               0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A,
                               0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73, 0x74,
                               0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x20, 0x21, 0x22, 0x23}; 
int row, col, init_row_col;

int main(void) {

    int bttn[4] = {0};
    int switch_val, led_val;
    int temp_val0;
    
    int state, echo;
    int score_cntr = 0;
    row = 0;    
    col = 0; 
    init_row_col = 0x0 | row << 10 | col;

    WR_GPIO(RGPIO0_OE, ALL_LEDS);
    WR_GPIO(RGPIO1_OE, 0x00000000);
    WR_GPIO(SYSCON_EN, 0x30);

    config_uart();  // initialize the uart

    while(1) {
        temp_val0    = RD_GPIO(PMODD_STATE);
        switch_val = RD_GPIO(RGPIO0_IN);
        led_val      = switch_val >> 16;

        WR_GPIO(RGPIO0_OUT, led_val);

        state     = temp_val0 & (0x00000002);
        echo      = temp_val0 & (0x00000001);

        temp_val0    = RD_GPIO(RGPIO1_IN);

        bttn[0] = temp_val0 & (0x00000001); // Mask BTN[0]
        bttn[1] = temp_val0 & (0x00000002); // Mask BTN[1]  
        bttn[2] = temp_val0 & (0x00000004); // Mask BTN[2]  
        bttn[3] = temp_val0 & (0x00000008); // Mask BTN[3]  
 
        ee_printf("STATE = %d and ECHO = %d\n", state, echo);
        delay();

        // Check if sw[0] is set
        if (switch_val & 0x00010000) {
            // Check if the state is DETECTED
            if (state) {
                score_cntr++;
                vga_display_hit(score_cntr);
            }
            
            // NOT DETECTED
            else {
                vga_display_miss(score_cntr);
            }
        }

        // sw[0] not set; welcome screen
        else {
            vga_display_welcome();
        }
    }

    return 0;
}

void delay(void) {
    for (int i = WAIT_DELAY; i > 0; i--) {}
}

void vga_display_welcome(void) {
    row = 240;
    col = 320;

    str2ascii(row, col, "interactive basketball !");
}

void vga_display_hit(int _val) {
    row = 639;
    col = 0;

    char num_val[2] = {_val + '0', '\0'};
    str2ascii(row, col, "score is ");

    col = 9;

    str2ascii(row, col, num_val);
}

void vga_display_miss(int _val) {
    row = 240;
    col = 320;

    str2ascii(row, col, "you missed !");

    row = 639;
    col = 0;
    char num_val[2] = {_val + '0', '\0'};
    str2ascii(row, col, "score is ");

    col = 9;
    str2ascii(row, col, num_val);
}

void str2ascii(int _row, int _col, char *string) {
    int i = 0;
    while (string[i] != '\0') {
        init_row_col = 0x0 | row << 10 | col;

        switch (string[i]) {
            // 0
            case 0x30:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[0]);
                i++;  
                col++;
                break;
            // 1
            case 0x31:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[1]);
                i++;  
                col++;
                break;
            // 2
            case 0x32:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[2]);
                i++;  
                col++;
                break;
            // 3
            case 0x33:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[3]);
                i++;  
                col++;
                break;
            // 4
            case 0x34:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[4]);
                i++;  
                col++;
                break;
            // 5
            case 0x35:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[5]);
                i++;  
                col++;
                break;
            // 6
            case 0x36:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[6]);
                i++;  
                col++;
                break;
            // 7
            case 0x37:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[7]);
                i++;  
                col++;
                break;
            // 8
            case 0x38:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[8]);
                i++;  
                col++;
                break;
            // 9
            case 0x39:
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[9]);
                i++;  
                col++;
                break;
            // a
            case 0x61:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[10]);  
                i++;
                col++;
                break;
            // b
            case 0x62:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[11]);  
                i++;
                col++;
                break;
            // c
            case 0x63:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[12]);  
                i++;
                col++;
                break;
            // d
            case 0x64:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[13]);  
                i++;
                col++;
                break;
            // e
            case 0x65:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[14]);  
                i++;
                col++;
                break;
            // f
            case 0x66:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[15]);  
                i++;
                col++;
                break;
            // g
            case 0x67:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[16]);  
                i++;
                col++;
                break;
            // h
            case 0x68:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[17]);  
                i++;
                col++;
                break;
            // i
            case 0x69:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[18]);  
                i++;
                col++;
                break;
            // j
            case 0x6A:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[19]);  
                i++;
                col++;
                break;
            // k
            case 0x6B:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[20]);  
                i++;
                col++;
                break;
            // l
            case 0x6C:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[21]);  
                i++;
                col++;
                break;
            // m
            case 0x6D:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[22]);  
                i++;
                col++;
                break;
            // n
            case 0x6E:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[23]);  
                i++;
                col++;
                break;
            // o
            case 0x6F:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[24]);  
                i++;
                col++;
                break;
            // p
            case 0x70:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[25]);  
                i++;
                col++;
                break;
            // q
            case 0x71:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[26]);  
                i++;
                col++;
                break;
            // r
            case 0x72:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[27]);  
                i++;
                col++;
                break;
            // s
            case 0x73:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[28]);  
                i++;
                col++;
                break;
            // t
            case 0x74:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[29]);  
                i++;
                col++;
                break;
            // u
            case 0x75:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[30]);  
                i++;
                col++;
                break;
            // v
            case 0x76:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[31]);  
                i++;
                col++;
                break;
            // w
            case 0x77:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[32]);  
                i++;
                col++;
                break;
            // x
            case 0x78:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[33]);  
                i++;
                col++;
                break;
            // y
            case 0x79:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[34]);  
                i++;
                col++;
                break;
            // z
            case 0x7A:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[35]);  
                i++;
                col++;
                break;
            // space
            case 0x20:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[36]);  
                i++;
                col++;
                break;
            // !
            case 0x21:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[37]);  
                i++;
                col++;
                break;
            // "
            case 0x22:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[38]);  
                i++;
                col++;
                break;
            // #
            case 0x23:     
                WR_GPIO(VGACON_ROWCOL, init_row_col);
                WR_GPIO(VGACON_DATA, ascii_char[39]);  
                i++;
                col++;
                break;
        }
    }
}
