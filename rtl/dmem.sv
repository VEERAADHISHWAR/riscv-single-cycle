`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 15:39:47
// Design Name: 
// Module Name: dmem
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


module dmem (
    input  logic        clk, we,
    input  logic [31:0] addr, wd,
    output logic [31:0] rd
);
    logic [31:0] mem [0:255];
    initial for (int i = 0; i < 256; i++) mem[i] = 32'b0;
    assign rd = mem[addr[9:2]];
    always_ff @(posedge clk)
        if (we) mem[addr[9:2]] <= wd;
endmodule
