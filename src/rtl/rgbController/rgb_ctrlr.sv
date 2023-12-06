/*
* Author: Ibrahim Binmahfood
* ECE540, Kravitz
* Project 1, Part 3: RGB LED Controller - rtl module
* 11/01/2023
*
* Platform: RVfpga on Boolean Board
* Description: The 'rgbPWM' module was implemented by Roy Kravitz. The rtl
* module below instantiates for two RGB LEDs. There are four registers that can
* be accessed at specific addresses. RGB0 and RGB1 can be controlled with
* respect to their control registers.
*
*/

module rgb_ctrlr
    (input wire logic i_clk,
     input wire logic i_rst,
     // Wishbone Interface
     input wire logic [5:0] i_wb_adr,   // only need 6 bits for 6 registers
     input wire logic [31:0] i_wb_dat,  
     input wire logic [3:0] i_wb_sel,   // At most need 4 select lines
     input wire logic i_wb_we,
     input wire logic i_wb_cyc,
     input wire logic i_wb_stb,
     output logic [31:0] o_wb_dat,      // Have 32 bit register peripherals
     output logic o_wb_ack,
     // RGB LEDs
     output wire logic [2:0] o_rgb0_led, // RGB[0] = B; RGB[1] = G; RGB[2] = R;
     output wire logic [2:0] o_rgb1_led);

    
    // Register Write Enable:
    //
    // Only where there is bus cycle in progress AND incoming strobe AND
    // incoming write enable and no ACK
    wire logic reg_we = i_wb_cyc & i_wb_stb & i_wb_we & (!o_wb_ack);

    // Register Read Enable:
    // 
    // Only where there is bus cycle in progress AND incoming strobe AND
    // no incoming write enable AND no ACK from slave
    wire logic reg_re = i_wb_cyc & i_wb_stb & (!i_wb_we) & (!o_wb_ack);
    
    // Control Registers
    logic [31:0] rgb0_ctrl_reg;
    logic [31:0] rgb1_ctrl_reg;
    // Duty Cycle Counters
    logic [31:0] rgb0_dc_cntr;
    logic [31:0] rgb1_dc_cntr;
    // PWM Counter Clocks
    logic rgb0_pwm_clk_cnt;
    logic rgb1_pwm_clk_cnt;

    always_ff @(posedge i_clk) begin
        // if valid bus cycle in progress AND no ACK
        o_wb_ack <= i_wb_cyc & !o_wb_ack;

        if (i_rst) o_wb_ack <= 1'b0; // if reset is asserted ouput the ack as 0
        
        // Register Write Enable asserted
        if (reg_we) begin
            // sweep through addresses
            case (i_wb_adr[5:2])
                // 0x0-0x3
                0: begin
                    // Blue bitfield : [9:0] 
                    if (i_wb_sel[0]) rgb0_ctrl_reg[9:0]   <= i_wb_dat[9:0]; 
                    // Green bitfield : [19:10] 
                    if (i_wb_sel[1]) rgb0_ctrl_reg[19:10] <= i_wb_dat[19:10];
                    // Red bitfield : [29:20] 
                    if (i_wb_sel[2]) rgb0_ctrl_reg[29:20] <= i_wb_dat[29:20];
                    // PWM Enable bit
                    if (i_wb_sel[3]) rgb0_ctrl_reg[31]    <= i_wb_dat[31];
                end
                // 0x4-0x7
                1: begin 
                    // Blue bitfield : [9:0] 
                    if (i_wb_sel[0]) rgb1_ctrl_reg[9:0]   <= i_wb_dat[9:0];
                    // Green bitfield : [19:10] 
                    if (i_wb_sel[1]) rgb1_ctrl_reg[19:10] <= i_wb_dat[19:10];
                    // Red bitfield : [29:20] 
                    if (i_wb_sel[2]) rgb1_ctrl_reg[29:20] <= i_wb_dat[29:20];
                    // PWM Enable bit
                    if (i_wb_sel[3]) rgb1_ctrl_reg[31]    <= i_wb_dat[31]; 
                end
            endcase
        end

        // Register Read Enable asserted
        if (reg_re) begin
            // sweep through addresses
            case(i_wb_adr[5:2])
                // 0x8-0xB
                2: o_wb_dat[31:0] <= rgb0_dc_cntr[31:0];
                // 0xC-0xF
                3: o_wb_dat[31:0] <= rgb1_dc_cntr[31:0];
                // 0x10-0x13
                4: o_wb_dat[31:0] <= {31'd0, rgb0_pwm_clk_cnt};
                // 0x14-0x17
                5: o_wb_dat[31:0] <= {31'd0, rgb1_pwm_clk_cnt};
            endcase
        end
    end

    // RGB0 and RGB1 LEDs
    rgbPWM rgb0
        (.clk         (i_clk),
         .resetn      (~i_rst),
         .controlReg  (rgb0_ctrl_reg),
         .rgbRED      (o_rgb0_led[2]),
         .rgbGREEN    (o_rgb0_led[1]),
         .rgbBLUE     (o_rgb0_led[0]),
         .clkPWM      (rgb0_pwm_clk_cnt),               
         .pwmcount    (rgb0_dc_cntr));

     rgbPWM rgb1
        (.clk         (i_clk),
         .resetn      (~i_rst),
         .controlReg  (rgb1_ctrl_reg),
         .rgbRED      (o_rgb1_led[2]),
         .rgbGREEN    (o_rgb1_led[1]),
         .rgbBLUE     (o_rgb1_led[0]),
         .clkPWM      (rgb1_pwm_clk_cnt),               
         .pwmcount    (rgb1_dc_cntr));
    
endmodule
