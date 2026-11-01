`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 14:14:19
// Design Name: 
// Module Name: alu
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



module alu (

    //================================================
    // 1. INPUT AND OUTPUT PORT DECLARATIONS
    //================================================

    input  logic [31:0] a,
    input  logic [31:0] b,

    input  logic [3:0] alu_ctrl,

    output logic [31:0] result,
    output logic zero

);


    //================================================
    // 2. ALU OPERATION LOGIC
    //================================================

    always_comb begin

        case (alu_ctrl)


            // ---------------------------------------
            // ARITHMETIC OPERATIONS
            // ---------------------------------------

            4'b0000: result = a + b;       // ADD

            4'b0001: result = a - b;       // SUB


            // ---------------------------------------
            // LOGICAL OPERATIONS
            // ---------------------------------------

            4'b0010: result = a & b;       // AND

            4'b0011: result = a | b;       // OR

            4'b0100: result = a ^ b;       // XOR


            // ---------------------------------------
            // SHIFT OPERATIONS
            // ---------------------------------------

            4'b0101: result = a << b[4:0]; // SLL

            4'b0110: result = a >> b[4:0]; // SRL

            4'b0111: result = $signed(a) >>> b[4:0]; // SRA


            // ---------------------------------------
            // COMPARISON OPERATIONS
            // ---------------------------------------

            4'b1000: result = {
                31'b0,
                ($signed(a) < $signed(b))
            };                             // SLT

            4'b1001: result = {
                31'b0,
                (a < b)
            };                             // SLTU


            // ---------------------------------------
            // DEFAULT OPERATION
            // ---------------------------------------

            default: result = 32'b0;

        endcase

    end


    //================================================
    // 3. ZERO FLAG GENERATION
    //================================================

    assign zero = (result == 32'b0);


endmodule

