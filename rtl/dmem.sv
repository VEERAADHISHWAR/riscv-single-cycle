`timescale 1ns / 1ps

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
