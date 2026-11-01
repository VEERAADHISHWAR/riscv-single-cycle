`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 15:03:05
// Design Name: 
// Module Name: pc_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pc_tb;
    logic clk = 0, rst = 1;
    logic [31:0] pc_next, pc_o;
    pc dut (.clk, .rst, .pc_next, .pc(pc_o));
    always #5 clk = ~clk;

    initial begin
        pc_next = 32'h20;
        @(posedge clk); #1; assert (pc_o === 0) else $error("reset");
        rst = 0; @(posedge clk); #1; assert (pc_o === 32'h20) else $error("load");
        pc_next = 32'h24; @(posedge clk); #1; assert (pc_o === 32'h24) else $error("update");
        rst = 1; @(posedge clk); #1; assert (pc_o === 0) else $error("reset again");
        $display("PC tests done");
        $finish;
    end
endmodule
