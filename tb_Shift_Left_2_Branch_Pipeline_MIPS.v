`timescale 1ns/1ps

module tb_Shift_Left_2_Branch_Pipeline_MIPS;

    // 1. Signals declaration
    reg  [31:0] SignImmE;           // Input register
    wire [31:0] SignImmShiftedE;    // Output wire

    // 2. Unit Under Test (UUT) Instantiation
    Shift_Left_2_Branch_Pipline_MIPS uut (
        .SignImmE(SignImmE),
        .SignImmShiftedE(SignImmShiftedE)
    );

    // 3. Test vectors generation
    initial begin
        $display("==================================================");
        $display("Starting Shift Left 2 Unit Testbench...");
        $display("==================================================");

        // Test Case 1: Zero Input (0x4 = 0)
        SignImmE = 32'd0; #10;
        if (SignImmShiftedE === 32'd0)
            $display("[PASS] Input: 0 -> Output: %d (Correct)", SignImmShiftedE);
        else
            $display("[FAIL] Input: 0 -> Expected: 0, Got: %d", SignImmShiftedE);

        // Test Case 2: Positive Number (1x4 = 4)
        SignImmE = 32'd1; #10; 
        if (SignImmShiftedE === 32'd4)
            $display("[PASS] Input: 1 -> Output: %d (Correct)", SignImmShiftedE);
        else
            $display("[FAIL] Input: 1 -> Expected: 4, Got: %d", SignImmShiftedE);

        // Test Case 3: Positive Number (15x4 = 60)
        SignImmE = 32'd15; #10; 
        if (SignImmShiftedE === 32'd60)
            $display("[PASS] Input: 15 -> Output: %d (Correct)", SignImmShiftedE);
        else
            $display("[FAIL] Input: 15 -> Expected: 60, Got: %d", SignImmShiftedE);

        // Test Case 4: Negative Number (-1x4 = -4)
        SignImmE = -32'd1; #10; 
        if (SignImmShiftedE === -32'd4)
            $display("[PASS] Input: -1 -> Output: %d (Correct)", $signed(SignImmShiftedE));
        else
            $display("[FAIL] Input: -1 -> Expected: -4, Got: %d", $signed(SignImmShiftedE));

        // Test Case 5: Overflow Check (MSB bits should drop)
        SignImmE = 32'b1100_0000_0000_0000_0000_0000_0000_0011; #10; 
        if (SignImmShiftedE === 32'd12)
            $display("[PASS] Boundary/Overflow Check Correct. Shifting dropped MSB bits.");
        else
            $display("[FAIL] Boundary/Overflow Mismatch! Got: %b", SignImmShiftedE);

        $display("==================================================");
        $display("Shift Left 2 Testbench Finished.");
        $display("==================================================");
        $finish; // End simulation
    end

endmodule