`timescale 1ns / 1ps

module regfile_tb;
    logic clk = 0, we;
    logic [4:0]  ra1, ra2, wa;
    logic [31:0] wd, rd1, rd2;
    regfile dut (.*);
    always #5 clk = ~clk;

    initial begin
        we = 1; wa = 5;  wd = 32'hAB; @(posedge clk); #1;
        wa = 10; wd = 32'hCD;         @(posedge clk); #1;
        we = 0; ra1 = 5; ra2 = 10; #1;
        assert (rd1 === 32'hAB && rd2 === 32'hCD) else $error("read/write failed");

        we = 1; wa = 0; wd = 32'hFFFF; @(posedge clk); #1;
        ra1 = 0; #1;
        assert (rd1 === 0) else $error("x0 was written");

        we = 0; wa = 5; wd = 32'h1234; @(posedge clk); #1;
        ra1 = 5; #1;
        assert (rd1 === 32'hAB) else $error("wrote while we=0");

        $display("Regfile tests done");
        $finish;
    end
endmodule
