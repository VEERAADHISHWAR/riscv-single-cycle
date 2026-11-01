`timescale 1ns / 1ps

module imem (
    input  logic [31:0] addr,
    output logic [31:0] instr
);
    logic [31:0] mem [0:255];
    initial for (int i = 0; i < 256; i++) mem[i] = 32'b0;
    assign instr = mem[addr[9:2]];
endmodule
