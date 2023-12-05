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

#include "hc_sr04.h"
#include "vga.h"
#include "ssegment.h"

// GPIO0 Module Registers
#define RGPIO0_IN       0x80001400
#define RGPIO0_OUT      0x80001404
#define RGPIO0_OE       0x80001408

// GPIO1 Module Registers
#define RGPIO1_IN       0x80001800
#define RGPIO1_OUT      0x80001804
#define RGPIO1_OE       0x80001808

#define ALL_LEDS        0x0000FFFF
#define WAIT_DELAY      1000000

// Global Variables
extern uint8_t game_state;
extern uint32_t on_off_state;

void delay(void);

int main(void) {

    int bttn[4] = {0};
    int switch_val, led_val;
    int temp_val0;
    
    int state, echo;
    int score_cntr = 0;

    game_state = 0;
    on_off_state = game_state ? ON_STATE : OFF_STATE;

    WR_GPIO(RGPIO0_OE, ALL_LEDS);
    WR_GPIO(RGPIO1_OE, 0x00000000);
    sseg_init(0x10);
    delay();

    config_uart();  // initialize the uart

    sseg_write(on_off_state | (1 << 12));
    delay();
    while(1) {
        temp_val0    = RD_GPIO(RGPIO1_IN);
        switch_val   = RD_GPIO(RGPIO0_IN);
        led_val      = switch_val >> 16;

        WR_GPIO(RGPIO0_OUT, led_val);

        state     = get_status();
        echo      = get_echo_pulse();

        bttn[0] = temp_val0 & (0x00000001); // Mask BTN[0]
        bttn[1] = temp_val0 & (0x00000002); // Mask BTN[1]  
        bttn[2] = temp_val0 & (0x00000004); // Mask BTN[2]  
        bttn[3] = temp_val0 & (0x00000008); // Mask BTN[3]  
        
        //hc_sr04_debug();
        
        //delay();

        on_off_state = game_state ? ON_STATE : OFF_STATE;

        // Check if sw[0] is set
        if (switch_val & 0x00010000) {
            game_state = 1;
            sseg_write(on_off_state | 0);
            
            // Check if the state is DETECTED
            if (state) {
                score_cntr++;
                vga_display_hit(score_cntr);
            }

            // Top score reached
            else if (score_cntr == 5){
                //vga_display_win()
                score_cntr = 0;
                game_state = 0;
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
