/*
 * Authors: Ibrahim Binmahfood, Robert Wilcox, andMohamed Gnedi
 * ECE540, Kravitz
 * Final Project, PMOD D Controller - rtl module
 * 11/24/2023
 *
 * Platform: RVfpga on Boolean Board
 * Description: 
 *
 */

module pmod_D_ctrlr
    (input wire logic i_clk,
     input wire logic i_rst,
     // Wishbone Interface
     input wire logic [5:0] i_wb_adr,         // at require 6 bits for addresses in mind
     input wire logic [31:0] i_wb_dat,        
     input wire logic [3:0] i_wb_sel,         // at most only need 4 select lines
     input wire logic i_wb_we,
     input wire logic i_wb_cyc,
     input wire logic i_wb_stb,
     output logic [31:0] o_wb_dat,
     output logic o_wb_ack,
     // Ultrasonic Sensor (HC-SR04) signals
     input wire logic   i_sensor_clk,   // @64 MHz
     output logic  o_trigger,      // trigger pin
     input logic   i_echo);        // echo pin 

    // Register Write Enable:
    //
    // Only when valid bus cycle in progress AND incoming strobe AND incoming
    // write enable AND no ACK signal from slave
    //wire logic reg_we = i_wb_cyc & i_wb_stb & i_wb_we & (!o_wb_ack);

    // Register Read Enable:
    //
    // Only when valid bus cycle in progress AND incoming strobe AND no incoming
    // write enable AND no ACK signal from slave
    wire logic reg_re = i_wb_cyc & i_wb_stb & (!i_wb_we) & (!o_wb_ack);

    // Wishbone Peripheral Interfacing
    always_ff @(posedge i_clk) begin
        // if valid bus cycle in progress AND no ACK signal
        o_wb_ack <= i_wb_cyc & !o_wb_ack;

        if (i_rst) begin
            o_wb_ack    <= 1'b0; // if reset asserted then let ack = 0
        end
/*
        // Register Write Enable asserted
        if (reg_we) begin
            // sweep through addresses
            unique case (i_wb_adr[5:2])
                // 0x00              // Enable a pulse to Trigger
                0: if (i_wb_sel[0])  pulse_trig  <=  i_wb_dat[0];
            endcase
        end
*/
        // Register Read Enable asserted
        if (reg_re) begin
            // sweep through addresses
            unique case (i_wb_adr[5:2])
                // 0x00    
                0: o_wb_dat[31:0] <= {30'd0, state, i_echo};
            endcase
        end
    end
    
    ultrasonic_sensor hc_sr04
        (.clk            (i_sensor_clk),
         .rst            (1'b0),
         .trigger_pulse  (o_trigger),
         .echo_pulse     (i_echo),
         .state          (state));
    
endmodule
