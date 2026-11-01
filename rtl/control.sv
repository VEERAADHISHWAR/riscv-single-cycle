`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 16:14:24
// Design Name: 
// Module Name: control
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


module control (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic       funct7_5,
    output logic       reg_write, alu_src, mem_write, mem_to_reg, branch, jump,
    output logic [3:0] alu_ctrl
);
    always_comb begin
        reg_write = 0; alu_src = 0; mem_write = 0; mem_to_reg = 0;
        branch = 0; jump = 0; alu_ctrl = 4'b0000;
        case (opcode)
            7'b0110011, 7'b0010011: begin                       // R-type, I-type ALU
                reg_write = 1;
                alu_src   = (opcode == 7'b0010011);
                case (funct3)
                    3'b000: alu_ctrl = (opcode == 7'b0110011 && funct7_5) ? 4'b0001 : 4'b0000;
                    3'b001: alu_ctrl = 4'b0101;
                    3'b010: alu_ctrl = 4'b1000;
                    3'b011: alu_ctrl = 4'b1001;
                    3'b100: alu_ctrl = 4'b0100;
                    3'b101: alu_ctrl = funct7_5 ? 4'b0111 : 4'b0110;
                    3'b110: alu_ctrl = 4'b0011;
                    3'b111: alu_ctrl = 4'b0010;
                endcase
            end
            7'b0000011: begin reg_write = 1; alu_src = 1; mem_to_reg = 1; end   // lw
            7'b0100011: begin alu_src = 1; mem_write = 1; end                   // sw
            7'b1100011: begin branch = 1; alu_ctrl = 4'b0001; end               // beq/bne
            7'b1101111: begin reg_write = 1; jump = 1; end                      // jal
        endcase
    end
endmodule
