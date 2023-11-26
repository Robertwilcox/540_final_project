/*
 * Author: Josh Macfie
 * Source Code originated from: https://github.com/josh-macfie/sonarSense 
 *
 * Modified by: Ibrahim Binmahfood
 * ECE540, Kravitz
 * Final Project, Ultrasonic Sensor - rtl module
 * 11/26/2023
 *
 * Platform: RVfpga on Boolean Board
 * Description: The origin of this code was implemented by Josh Macfie in
 * Verilog. However, I ported it to System Verilog and took into account the
 * clock frequency Josh had used on his Basys 2 board. The 'clk' input wire is
 * intended for a 64 MHz clock. 'status' output variable is used to know if
 * there is an obstacle 'detected' or 'not detected'.
 *
 */

module ultrasonic_sensor
    (input wire logic clk,          // @64 MHz
     input wire logic rst,
     output wire logic trigger_pulse,
     input wire logic echo_pulse,
     output wire logic state);

    logic [25:0] counter;
    logic [32:0] echo_pulse_cnt;
    logic [32:0] output_cnt;
    logic [32:0] status_filter;

    logic prev_echo_pulse;
    logic n_trigger;

    always_ff @(posedge clk) begin
        counter   <= counter + 1;        // increment counter

        // Pulse of 1us every 1ms
        n_trigger <= ~&(counter[24:10]); // pick out specified time for trig ctrl

        // Reset signals
        if (rst) begin
            counter         <= '0;
            echo_pulse_cnt  <= '0;
            status_filter   <= '0;
            prev_echo_pulse <= '0;
            n_trigger       <= '0; 
        end

        // IF 1 MSB more from n_trigger then enter if statement
        if (~&(counter[24:11])) begin
            // IF n_trigger = 1 then count pulse of echo AND OR send that count
            // out to 'status' 
            if (n_trigger) begin
                if (echo_pulse == 1) echo_pulse_cnt <= echo_pulse_cnt + 1;
                if ((prev_echo_pulse == 1) && (echo_pulse == 0)) begin
                    output_cnt <= echo_pulse_cnt;
                    echo_pulse_cnt <= 0;
                end
            end
        end

        // This number is the distance control, the status is used as a buffer
        // for filtering (OR Filter)
        if (output_cnt > 33'h0_0000_E9F0) begin
            status_filter <= status_filter << 1;
            status_filter[0] <= 1;
        end
        else begin
            status_filter <= status_filter << 1;
            status_filter[0] <= 0;
        end
        prev_echo_pulse <= echo_pulse;
    end

    assign trigger_pulse = n_trigger;   // connect to port output
    assign state = |status_filter;      // LOGIC OR Filter

endmodule
