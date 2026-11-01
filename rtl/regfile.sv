`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 14:17:13
// Design Name: 
// Module Name: regfile
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


module regfile (
    input  logic        clk, we,
    input  logic [4:0]  ra1, ra2, wa,
    input  logic [31:0] wd,
    output logic [31:0] rd1, rd2
);
    logic [31:0] regs [31:0];
    initial for (int i = 0; i < 32; i++) regs[i] = 32'b0;

    always_ff @(posedge clk)
        if (we && wa != 0) regs[wa] <= wd;

    assign rd1 = (ra1 == 0) ? 32'b0 : regs[ra1];
    assign rd2 = (ra2 == 0) ? 32'b0 : regs[ra2];
endmodule