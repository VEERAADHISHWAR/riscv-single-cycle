`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 16:15:11
// Design Name: 
// Module Name: control_tb
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


module control_tb;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic       funct7_5, reg_write, alu_src, mem_write, mem_to_reg, branch, jump;
    logic [3:0] alu_ctrl;
    control dut (.*);

    initial begin
        opcode = 7'b0110011; funct3 = 0; funct7_5 = 0; #1;   // add
        assert (reg_write && !alu_src && alu_ctrl === 4'b0000) else $error("add");
        funct7_5 = 1; #1;                                    // sub
        assert (alu_ctrl === 4'b0001) else $error("sub");
        opcode = 7'b0010011; funct7_5 = 0; #1;               // addi
        assert (reg_write && alu_src && alu_ctrl === 4'b0000) else $error("addi");
        opcode = 7'b0000011; funct3 = 3'b010; #1;            // lw
        assert (reg_write && alu_src && mem_to_reg) else $error("lw");
        opcode = 7'b0100011; #1;                             // sw
        assert (mem_write && alu_src && !reg_write) else $error("sw");
        opcode = 7'b1100011; funct3 = 0; #1;                 // beq
        assert (branch && alu_ctrl === 4'b0001 && !reg_write) else $error("beq");
        opcode = 7'b1101111; #1;                             // jal
        assert (jump && reg_write) else $error("jal");
        $display("Control tests done");
        $finish;
    end
endmodule
