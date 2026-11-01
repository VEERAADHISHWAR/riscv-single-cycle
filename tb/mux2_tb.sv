`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 15:56:25
// Design Name: 
// Module Name: mux2_tb
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


module mux2_tb;
    logic [31:0] d0, d1, y;
    logic s;
    mux2 dut (.*);

    initial begin
        d0 = 32'hAAAA; d1 = 32'hBBBB;
        s = 0; #1; assert (y === 32'hAAAA) else $error("s=0");
        s = 1; #1; assert (y === 32'hBBBB) else $error("s=1");
        $display("Mux2 tests done");
        $finish;
    end
endmodule