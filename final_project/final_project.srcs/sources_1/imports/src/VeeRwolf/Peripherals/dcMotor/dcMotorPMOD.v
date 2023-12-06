module dcMotorPMOD (
    input wire         i_clk,     // System clock
    input wire         i_rst,     // System reset
    input wire  [5:0]  i_wb_adr,  // Wishbone address
    input wire  [31:0] i_wb_dat,  // Wishbone data input
    input wire  [3:0]  i_wb_sel,  // Wishbone byte select
    input wire         i_wb_we,   // Wishbone write enable
    input wire         i_wb_cyc,  // Wishbone cycle
    input wire         i_wb_stb,  // Wishbone strobe
    output reg  [31:0] o_wb_dat,  // Wishbone data output
    output reg         o_wb_ack,  // Wishbone acknowledge
    output reg         o_pmod_pin // Output to PMOD pin
);

    reg pmod_control_reg;  // Register to control PMOD pin

    // Synchronize the external reset signal to the clock domain
    always @(posedge i_clk) begin
        if (i_rst) begin
            pmod_control_reg <= 0;
            o_wb_ack <= 0;
        end else begin
            // Wishbone interface logic
            if (i_wb_cyc && i_wb_stb && !o_wb_ack) begin
                o_wb_ack <= 1;  // Acknowledge on next cycle after strobe
                if (i_wb_we) begin
                    // Handle write operations
                    case (i_wb_adr[5:2])
                        4'b0000: begin
                            if (i_wb_sel[0]) pmod_control_reg <= i_wb_dat[0]; // Write to PMOD control register
                        end
                        // Additional cases can be added here for other addresses
                    endcase
                end
                o_wb_dat <= {31'b0, pmod_control_reg}; // Read from PMOD control register
            end else begin
                o_wb_ack <= 0;  // Clear the acknowledge signal
            end
        end

        // Update the PMOD output pin based on control register
        o_pmod_pin <= pmod_control_reg;
    end

endmodule
