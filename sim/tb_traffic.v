// Testbench for traffic.v: runs the FSM with a 1-"second" enable pulse every
// 10 clock cycles, and presses the pedestrian button partway through Road 1.
`timescale 1ns / 1ps
module tb_traffic;
    reg clk = 0, reset = 1, EN = 0, ped_req = 0;
    wire S1_Green, S2_Green, S3_Green, Ped_Green;
    wire [3:0] time_S1, time_S2, time_S3, time_PED;

    traffic dut (clk, reset, EN, ped_req, S1_Green, S2_Green, S3_Green, Ped_Green,
                 time_S1, time_S2, time_S3, time_PED);

    always #5 clk = ~clk;

    // One-cycle enable pulse every 10 clocks = one simulated second
    integer cyc = 0;
    always @(posedge clk) begin
        cyc <= cyc + 1;
        EN <= ((cyc % 10) == 9);
    end

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb_traffic);
        #25 reset = 0;
        // Pedestrian presses the button ~3 s into Road 1's green
        #300 ped_req = 1;
        #100 ped_req = 0;          // held for one simulated second
        #4600 $finish;             // ~50 simulated seconds total
    end
endmodule
