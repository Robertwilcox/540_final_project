/*
 * Authors: Ibrahim Binmahfood, Robert Wilcox, and Mohamed Gnedi
 * ECE540, Kravitz
 * Final Project, Ultrasonic Sensor - rtl module
 * 11/24/2023
 *
 * Platform: RVfpga on Boolean Board
 * Description: A HC-SR04 
 *
 */

module ultrasonic_sensor
    (input wire logic clk,          // @64 MHz
     input wire logic rst,
     output wire logic trigger_pulse,
     input wire logic echo_pulse,
     output wire logic state);

    logic [25:0] counter          = '0;
    logic [32:0] echo_pulse_cnt   = '0;
    logic [32:0] output_cnt       = '0;
    logic [32:0] status_filter    = '0;
    logic prev_echo_pulse         = '0;
    logic n_trigger               = '0;

    always_ff @(posedge clk) begin
        counter   <= counter + 1;
        n_trigger <= ~&(counter[24:10]); 

        if (rst) begin
            counter         <= '0;
            echo_pulse_cnt  <= '0;
            status_filter   <= '0;
            prev_echo_pulse <= '0;
            n_trigger       <= '0; 
        end

        if (~&(counter[24:11])) begin
            if (n_trigger) begin
                if (echo_pulse == 1) echo_pulse_cnt <= echo_pulse_cnt + 1;
                if ((prev_echo_pulse == 1) && (echo_pulse == 0)) begin
                    output_cnt <= echo_pulse_cnt;
                    echo_pulse_cnt <= 0;
                end
            end
        end

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

    assign trigger_pulse = n_trigger;
    assign state = |status_filter;

endmodule
