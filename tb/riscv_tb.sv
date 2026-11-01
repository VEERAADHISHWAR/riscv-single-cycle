`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 16:36:56
// Design Name: 
// Module Name: riscv_tb
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


module riscv_tb;
    logic clk = 0, rst = 1;
    riscv_top dut (.clk, .rst);
    always #5 clk = ~clk;

    task automatic chk(input int n, input [31:0] exp);
        assert (dut.u_rf.regs[n] === exp)
            else $error("x%0d = %h, expected %h", n, dut.u_rf.regs[n], exp);
    endtask

    initial begin
        dut.u_imem.mem[0]  = 32'h00500093; // addi x1,x0,5
        dut.u_imem.mem[1]  = 32'h00A00113; // addi x2,x0,10
        dut.u_imem.mem[2]  = 32'h002081B3; // add  x3,x1,x2
        dut.u_imem.mem[3]  = 32'h00302023; // sw   x3,0(x0)
        dut.u_imem.mem[4]  = 32'h00002203; // lw   x4,0(x0)
        dut.u_imem.mem[5]  = 32'h00418463; // beq  x3,x4,+8  (taken)
        dut.u_imem.mem[6]  = 32'h06300293; // addi x5,x0,99  (skipped)
        dut.u_imem.mem[7]  = 32'h00100313; // addi x6,x0,1
        dut.u_imem.mem[8]  = 32'h00209463; // bne  x1,x2,+8  (taken)
        dut.u_imem.mem[9]  = 32'h06300393; // addi x7,x0,99  (skipped)
        dut.u_imem.mem[10] = 32'h0080046F; // jal  x8,+8
        dut.u_imem.mem[11] = 32'h06300493; // addi x9,x0,99  (skipped)
        dut.u_imem.mem[12] = 32'h00700513; // addi x10,x0,7
        dut.u_imem.mem[13] = 32'h401105B3; // sub  x11,x2,x1

        repeat (2) @(posedge clk); #1 rst = 0;
        repeat (20) @(posedge clk); #1;

        chk(1, 5);  chk(2, 10); chk(3, 15); chk(4, 15);
        chk(5, 0);  chk(6, 1);  chk(7, 0);  chk(8, 44);
        chk(9, 0);  chk(10, 7); chk(11, 5);
        assert (dut.u_dmem.mem[0] === 15) else $error("mem[0] wrong");

        $display("RISC-V processor tests done");
        $finish;
    end
endmodule
