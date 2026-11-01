`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 16:28:32
// Design Name: 
// Module Name: immgen_tb
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


module immgen_tb;
    logic [31:0] instr, imm;
    immgen dut (.*);

    initial begin
        instr = 32'h00500093; #1; assert (imm === 5)          else $error("addi 5");
        instr = 32'hFFF00093; #1; assert (imm === 32'hFFFFFFFF) else $error("addi -1");
        instr = 32'h0020A423; #1; assert (imm === 8)          else $error("sw 8");
        instr = 32'h00208463; #1; assert (imm === 8)          else $error("beq 8");
        instr = 32'h008000EF; #1; assert (imm === 8)          else $error("jal 8");
        $display("Immgen tests done");
        $finish;
    end
endmodule
