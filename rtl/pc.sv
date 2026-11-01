`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 15:02:16
// Design Name: 
// Module Name: pc
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

module pc (
    input  logic        clk, rst,
    input  logic [31:0] pc_next,
    output logic [31:0] pc
);
    always_ff @(posedge clk)
        if (rst) pc <= 32'b0;
        else     pc <= pc_next;
endmodule