`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 15:53:50
// Design Name: 
// Module Name: adder_tb
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


module adder_tb;
    logic [31:0] a, b, y;
    adder dut (.*);

    initial begin
        a = 4; b = 8; #1;            assert (y === 12) else $error("4+8");
        a = 32'hFFFFFFFF; b = 1; #1; assert (y === 0)  else $error("overflow wrap");
        $display("Adder tests done");
        $finish;
    end
endmodule
