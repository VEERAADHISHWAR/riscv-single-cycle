`timescale 1ns / 1ps

module adder_tb;
    logic [31:0] a, b, y;
    adder dut (.*);

    initial begin
        a = 4; b = 8; #1;            assert (y === 12) else $error("4+8");
        a = 32'hFFFFFFFF; b = 1; #1; assert (y === 0)  else $error("overflow wrap");
        $display("Adder tests done");
        $finish;
    end
endmodule
