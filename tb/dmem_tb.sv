`timescale 1ns / 1ps

module dmem_tb;
    logic clk = 0, we = 0;
    logic [31:0] addr, wd, rd;
    dmem dut (.*);
    always #5 clk = ~clk;

    initial begin
        addr = 8; wd = 32'h1234; we = 1; @(posedge clk); #1; we = 0;
        assert (rd === 32'h1234) else $error("write/read");
        wd = 32'hFFFF; @(posedge clk); #1;
        assert (rd === 32'h1234) else $error("wrote with we=0");
        addr = 12; #1;
        assert (rd === 0) else $error("other address changed");
        $display("DMEM tests done");
        $finish;
    end
endmodule
