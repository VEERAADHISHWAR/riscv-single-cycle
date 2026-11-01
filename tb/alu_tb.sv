`timescale 1ns / 1ps

module alu_tb;

    //================================================
    // 1. DECLARE TESTBENCH SIGNALS
    //================================================

    logic [31:0] a;
    logic [31:0] b;
    logic [31:0] result;

    logic [3:0] alu_ctrl;
    logic zero;


    //================================================
    // 2. CONNECT ALU (DUT) TO TESTBENCH
    //================================================

    alu dut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );


    //================================================
    // 3. CREATE REUSABLE CHECK TASK
    //================================================

    task automatic check(
        input logic [3:0]  op,
        input logic [31:0] x,
        input logic [31:0] y,
        input logic [31:0] expected,
        input string       test_name
    );

        begin

            // Apply inputs
            a = x;
            b = y;
            alu_ctrl = op;

            // Wait for ALU output
            #1;

            // Compare actual and expected results
            if (result === expected) begin

                $display("%s : PASS", test_name);

            end
            else begin

                $error("%s : FAIL | Got = %h | Expected = %h",
                       test_name, result, expected);

            end

        end

    endtask


    //================================================
    // 4. EXECUTE ALL ALU TEST CASES
    //================================================

    initial begin

        $display("--------------------------------");
        $display("       ALU VERIFICATION START");
        $display("--------------------------------");


        // TEST 1: ADD
        check(4'b0000, 10, 3, 13, "ADD");


        // TEST 2: SUB
        check(4'b0001, 10, 3, 7, "SUB");


        // TEST 3: AND
        check(4'b0010,
              32'hF0F0, 32'hFF00,
              32'hF000, "AND");


        // TEST 4: OR
        check(4'b0011,
              32'hF0F0, 32'hFF00,
              32'hFFF0, "OR");


        // TEST 5: XOR
        check(4'b0100,
              32'hF0F0, 32'hFF00,
              32'h0FF0, "XOR");


        // TEST 6: SHIFT LEFT LOGICAL
        check(4'b0101, 1, 4, 16, "SLL");


        // TEST 7: SHIFT RIGHT LOGICAL
        check(4'b0110,
              32'h80000000, 4,
              32'h08000000, "SRL");


        // TEST 8: SHIFT RIGHT ARITHMETIC
        check(4'b0111,
              32'hF0000000, 4,
              32'hFF000000, "SRA");


        // TEST 9: SIGNED LESS THAN
        check(4'b1000, -1, 1, 1, "SLT");


        // TEST 10: UNSIGNED LESS THAN
        check(4'b1001, -1, 1, 0, "SLTU");


        // TEST 11: ZERO FLAG
        check(4'b0001, 5, 5, 0, "SUB ZERO");

        if (zero === 1'b1)
            $display("ZERO FLAG : PASS");
        else
            $error("ZERO FLAG : FAIL");


        //================================================
        // 5. END SIMULATION
        //================================================

        $display("--------------------------------");
        $display("       ALU VERIFICATION END");
        $display("--------------------------------");

        $finish;

    end

endmodule
