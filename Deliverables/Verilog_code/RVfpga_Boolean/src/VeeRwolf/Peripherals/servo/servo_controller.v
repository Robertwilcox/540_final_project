
/**
 * servo_controller.v
 *
 * @author      Robert Wilcox (wilcox6@pdx.edu)
 * @date        12/7/23
 *
 * PWM module to control servo motor via the pwm pins.
 * Write to register 01 value between 0-100 (PWM%)
 * 
 */
module servo_controller(
    output reg pwm_out,    // PWM output for servo

    // Wishbone signals
    input wire              wb_clk,             // Wishbone clock
    input wire              wb_rst,             // Wishbone reset
    input wire              wb_cyc,             // Wishbone cycle valid
    input wire              wb_stb,             // Wishbone strobe
    input wire              wb_we,              // Wishbone write enable
    input wire [3:0]        wb_sel,             // Wishbone byte select
    input wire [31:0]       wb_adr,             // Wishbone address
    input wire [31:0]       wb_dat_i,           // Wishbone data input
    output reg              wb_ack,             // Wishbone acknowledge
    output reg [31:0]       wb_dat_o,           // Wishbone data output
    output reg [31:0]       debug_counter,      // For observing the counter
    output reg [31:0]       debug_pwm_width_reg // For observing the pwm_width_reg
);

    reg [31:0] pwm_width_reg;   // Register to hold PWM pulse width
    reg [31:0] counter;         // Counter for PWM generation
    reg sync_reset;             // Synchronized reset signal

    // Synchronize the external reset signal to the clock domain
    always @(posedge wb_clk) begin
        sync_reset <= wb_rst;
    end

    // Counter Logic with synchronized reset
    always @(posedge wb_clk) begin
        if (sync_reset) begin
            counter <= 0;
        end
        else if (counter == 2000000 - 1) begin  // Reset at 2,000,000 cycles
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end

    // PWM generation logic
    always @(posedge wb_clk) begin
        if (counter < pwm_width_reg) begin
            pwm_out <= 1;
        end 
        else begin
            pwm_out <= 0;
        end
    end

    // Wishbone interface logic
    always @(posedge wb_clk) begin
        if (wb_rst) begin
            wb_ack <= 0;
        end else begin
            wb_ack <= wb_cyc && wb_stb && !wb_ack;                  // Acknowledge on next cycle after strobe
        end

        case (wb_adr[5:2])
            4'b0001: begin
                if (wb_we && wb_cyc && wb_stb && !wb_ack) begin
                    pwm_width_reg <= wb_dat_i;                      // Update PWM width register at the end of a cycle
                end
                wb_dat_o <= pwm_width_reg;                          // Read data from PWM width register
            end
            default: begin
                                                                    // Handle unexpected addresses or add additional functionality if needed
            end
        endcase
    end

    // Assign debug outputs for observation
    always @(posedge wb_clk) begin
        debug_counter <= counter;
        debug_pwm_width_reg <= pwm_width_reg;
    end

endmodule
