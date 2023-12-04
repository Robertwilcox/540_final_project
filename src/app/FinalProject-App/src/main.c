/*
 * Author: Ibrahim Binmahfood, Mohamed Gnedi, and Robert Wilcox
 * ECE540, Kravitz
 * Final Project, Application main.c
 * 12/03/2023
 *
 * Platform: RVfpga on the Boolean Board  
 * Description: 
 *
 */

#include "hc_sr04.h"
#include "vga.h"

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

#define ALL_LEDS        0x0000FFFF
#define WAIT_DELAY      100000

void delay(void);


int main(void) {

    int bttn[4] = {0};
    int switch_val, led_val;
    int temp_val0;
    
    int state, echo;
    int score_cntr = 0;
    //row = 0;    
    //col = 0; 
    //init_row_col = 0x0 | row << 10 | col;

    WR_GPIO(RGPIO0_OE, ALL_LEDS);
    WR_GPIO(RGPIO1_OE, 0x00000000);
    WR_GPIO(SYSCON_EN, 0x30);

    config_uart();  // initialize the uart

    while(1) {
        temp_val0    = RD_GPIO(RGPIO1_IN);
        switch_val   = RD_GPIO(RGPIO0_IN);
        led_val      = switch_val >> 16;

        WR_GPIO(RGPIO0_OUT, led_val);

        state     = get_status();
        echo      = get_echo_pulse();

ee_printf("STATE = %d and ECHO = %d\n", state, echo);

        bttn[0] = temp_val0 & (0x00000001); // Mask BTN[0]
        bttn[1] = temp_val0 & (0x00000002); // Mask BTN[1]  
        bttn[2] = temp_val0 & (0x00000004); // Mask BTN[2]  
        bttn[3] = temp_val0 & (0x00000008); // Mask BTN[3]  
 
        hc_sr04_debug();
        
        //delay();

        // Check if sw[0] is set
        if (switch_val & 0x00010000) {
            // Check if the state is DETECTED
            if (state) {
                score_cntr++;
                //vga_display_hit(score_cntr);
            }
            
            // NOT DETECTED
            else {
                //vga_display_miss(score_cntr);
            }
        }

        // sw[0] not set; welcome screen
        else {
            //vga_display_welcome();
        }
    }

    return 0;
}

void delay(void) {
    for (int i = WAIT_DELAY; i > 0; i--) {}
}
