`timescale 1ns / 1ps

module pc (
    input  logic        clk, rst,
    input  logic [31:0] pc_next,
    output logic [31:0] pc
);
    always_ff @(posedge clk)
        if (rst) pc <= 32'b0;
        else     pc <= pc_next;
endmodule