/**
 * rgb_top.v - Implements a 3-channel PWM circuit to control an RGB LED
 *
 * @author      Robert Wilcox (wilcox6@pdx.edu)
 * @date        3-Nov-2023
 *
 * Register-based peripheral wrapper for rgbPWM.V module developed
 * by Roy Kravits (roy.kravitz@pdx.edu) 14-Oct-2023. This module
 * provides a way to utilize PWM to control a total of 6 LEDs,
 * 2 each of BLUE, GREEN, and RED. each rgbPWM instance can
 * control one set of RGB LEDs. 
 * 
 * Write to address 0x80001900 will control RGB0 signals and 
 * write to address 0x80001904 will control RGB1 signals.
 * Read from address 0x80001908 will give RGB0 duty cycle
 * and read from address 0x8000190C will give RGB1 duty cycle.
 * 
 * Wishbone bus address decoder and control logic somewhat
 * based off of ptc_top module written by - Damjan Lampret, 
 * lampret@opencores.org, as part of the PTC project
 * http://www.opencores.org/cores/ptc/ which was provided
 * as part of the VeerWolf default peripherals.
 *
 * @note    The design is implemented in verilog 2001 instead of
 * SystemVerilog because I was unsure if SystemVerilog files
 * are supported by Vivado for this use. Roy left a note
 * mentioning something of the sort in his file, so I felt
 * it was safest to just use Verilog 2001
 */
 
`include "rgbPWM.v"

module rgb_top #(
    BASE_ADDR = 32'h80001900,
    HIGH_ADDR = 32'h80001940     // maximum count for the PWM counters
) 
(
    // Wishbone signals
    input wire          wb_clk_i,       // Wishbone clock
    input wire          wb_rst_i,       // Wishbone reset (active high)
    input wire          wb_cyc_i,       // Wishbone valid bus cycle
    input wire          wb_stb_i,       // Wishbone valid data strobe
    input wire          wb_we_i,        // Wishbone write enable
    input wire  [3:0]   wb_sel_i,       // Wishbone byte select
    input wire  [31:0]  wb_adr_i,       // Wishbone address
    input wire  [31:0]  wb_dat_i,       // Wishbone data input
    output wire         wb_ack_o,       // Wishbone acknowledge
    output wire [31:0]  wb_dat_o,        // Wishbone data output
    output wire         wb_err_o,

    // External interface
    output wire         pwm0_red_o,
    output wire         pwm0_green_o,
    output wire         pwm0_blue_o,
    output wire         pwm1_red_o,
    output wire         pwm1_green_o,
    output wire         pwm1_blue_o,
    output wire         PWM0clk,
    output wire         PWM1clk,
    output wire[31:0]   pwm0_count,
    output wire[31:0]   pwm1_count
);

    wire            rgb0_cntr_sel;  // RPTC_CNTR select
    wire            rgb0_dcc_sel;   // RPTC_HRC select
    wire            rgb1_cntr_sel;   // RPTC_LRC select
    wire            rgb1_dcc_sel;  // RPTC_CTRL select
    wire            resetn;
    wire            full_decoding;  // Full address decoding qualification

    reg [31:0]  rgb_duty_cycle;
    reg [31:0]  data_o_tmp;

    

    // Control Logic
    reg [31:0]  pwm0_control_reg;
    reg [31:0]  pwm1_control_reg;


    assign resetn = ~wb_rst_i;

    assign wb_ack_o = wb_cyc_i & wb_stb_i & !wb_err_o;
    assign full_decoding = 1'b1;

    assign wb_err_o = wb_cyc_i & wb_stb_i & (!full_decoding | (wb_sel_i != 4'b1111));

    assign rgb0_cntr_sel = wb_cyc_i & wb_stb_i & (wb_adr_i[3:0] == 4'b0000) & full_decoding; //0x0
    assign rgb0_dcc_sel = wb_cyc_i & wb_stb_i & (wb_adr_i[3:0] == 4'b1000) & full_decoding;  //0x8
    assign rgb1_cntr_sel = wb_cyc_i & wb_stb_i & (wb_adr_i[3:0] == 4'b0100) & full_decoding;  // 0x4
    assign rgb1_dcc_sel = wb_cyc_i & wb_stb_i & (wb_adr_i[3:0] == 4'b1100) & full_decoding;  // 0xC

    assign wb_dat_o = rgb_duty_cycle;

    // Create the control registers from the Wishbone data input
    // Wishbone Read/Write logic
    always @(posedge wb_clk_i or posedge wb_rst_i) begin
        if (wb_rst_i) begin
            pwm0_control_reg <= 32'b0; // Reset
            pwm1_control_reg <= 32'b0; // Reset
        end
        else if (rgb0_cntr_sel && wb_we_i) begin  // rgb0_cntrl
            pwm0_control_reg <= wb_dat_i;
        end
        else if (rgb1_cntr_sel && wb_we_i) begin  // rgb1_cntrl
            pwm1_control_reg <= wb_dat_i;
        end
        else if (rgb0_dcc_sel && ~wb_we_i) begin  // rgb0_dcc
            rgb_duty_cycle <= pwm0_control_reg;
        end
        else if (rgb1_dcc_sel && ~wb_we_i) begin  // rgb0_dcc
            rgb_duty_cycle <= pwm1_control_reg;
        end
        else begin
    end
    end

    

    // Instantiate rgbPWM module for RGB0
    rgbPWM #(
        .USE_DIVIDER(1'b0),    // 1 to enable clock divider.  0 to provide a direct clock
        .DIVIDE_COUNT(500),    // Clock divider terminal count
        .POLARITY(1'b1),       // 1 to drive PWM output high when active.  0 to invert the PWM output
        .MAX_COUNT(2048)
    ) 
    rgb0_pwm(
        .clk                        (wb_clk_i),
        .resetn                     (resetn),
        .controlReg                 (pwm0_control_reg), // Use pwm_control_reg directly
        .rgbRED                     (pwm0_red_o),      // Connect to new output
        .rgbGREEN                   (pwm0_green_o),    // Connect to new output
        .rgbBLUE                    (pwm0_blue_o),     // Connect to new output
        .clkPWM                     (PWM0clk),
        .pwmcount                   (pwm0_count)    // technically also debug but more useful
    );
    // Instantiate rgbPWM module for RGB1
    rgbPWM #(
        .USE_DIVIDER(1'b0),    // 1 to enable clock divider.  0 to provide a direct clock
        .DIVIDE_COUNT(500),    // Clock divider terminal count
        .POLARITY(1'b1),       // 1 to drive PWM output high when active.  0 to invert the PWM output
        .MAX_COUNT(2048)
    ) 
    rgb1_pwm(
        .clk                        (wb_clk_i),
        .resetn                     (resetn),
        .controlReg                 (pwm1_control_reg), // Use pwm_control_reg directly
        .rgbRED                     (pwm1_red_o),      // Connect to new output
        .rgbGREEN                   (pwm1_green_o),    // Connect to new output
        .rgbBLUE                    (pwm1_blue_o),     // Connect to new output
        .clkPWM                     (PWM1clk),
        .pwmcount                   (pwm1_count)    // technically also debug but more useful
    );

    

endmodule