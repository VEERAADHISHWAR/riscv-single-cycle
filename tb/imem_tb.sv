`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 15:23:46
// Design Name: 
// Module Name: imem_tb
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

module imem_tb;
    logic [31:0] addr, instr;
    imem dut (.*);

    initial begin
        dut.mem[0] = 32'hAAAA0001; dut.mem[1] = 32'hBBBB0002; dut.mem[255] = 32'hCCCC0003;
        addr = 0;     #1; assert (instr === 32'hAAAA0001) else $error("addr 0");
        addr = 4;     #1; assert (instr === 32'hBBBB0002) else $error("addr 4");
        addr = 32'h3FC; #1; assert (instr === 32'hCCCC0003) else $error("last word");
        $display("IMEM tests done");
        $finish;
    end
endmodule