`timescale 1ns / 1ps

module riscv_top (
    input logic clk, rst
);
    logic [31:0] pc_cur, pc_next, pc_plus4, pc_target, instr, imm;
    logic [31:0] rd1, rd2, alu_b, alu_result, dmem_rd, wb_mem, wd;
    logic        reg_write, alu_src, mem_write, mem_to_reg, branch, jump, zero, pc_src;
    logic [3:0]  alu_ctrl;

    assign pc_src = (branch & (instr[12] ? ~zero : zero)) | jump;   // beq: zero, bne: ~zero

    pc      u_pc    (.clk, .rst, .pc_next, .pc(pc_cur));
    imem    u_imem  (.addr(pc_cur), .instr);
    control u_ctrl  (.opcode(instr[6:0]), .funct3(instr[14:12]), .funct7_5(instr[30]),
                     .reg_write, .alu_src, .mem_write, .mem_to_reg, .branch, .jump, .alu_ctrl);
    regfile u_rf    (.clk, .we(reg_write), .ra1(instr[19:15]), .ra2(instr[24:20]),
                     .wa(instr[11:7]), .wd, .rd1, .rd2);
    immgen  u_imm   (.instr, .imm);
    mux2    u_alusrc(.d0(rd2), .d1(imm), .s(alu_src), .y(alu_b));
    alu     u_alu   (.a(rd1), .b(alu_b), .alu_ctrl, .result(alu_result), .zero);
    dmem    u_dmem  (.clk, .we(mem_write), .addr(alu_result), .wd(rd2), .rd(dmem_rd));
    mux2    u_wbmem (.d0(alu_result), .d1(dmem_rd), .s(mem_to_reg), .y(wb_mem));
    mux2    u_wbjmp (.d0(wb_mem), .d1(pc_plus4), .s(jump), .y(wd));
    adder   u_add4  (.a(pc_cur), .b(32'd4), .y(pc_plus4));
    adder   u_addbr (.a(pc_cur), .b(imm), .y(pc_target));
    mux2    u_pcsrc (.d0(pc_plus4), .d1(pc_target), .s(pc_src), .y(pc_next));
endmodule