`timescale 1ns/1ps
module tb_Control_Unit_Pipeline_MIPS; 
//  Inputs (Reg) and Outputs (Wire)
    reg  [5:0] funct;
    reg  [5:0] op;
    wire MemtoRegD,MemWriteD,BranchD,ALUSrcD,RegDstD,RegWriteD;
    wire [2:0] ALUControlD;
//  Instantiate Unit Under Test (UUT)
Control_Unit_Pipeline_MIPS uut 
(
.funct(funct) ,.op(op) ,.MemtoRegD(MemtoRegD) ,.MemWriteD(MemWriteD),
.BranchD(BranchD) ,.ALUControlD(ALUControlD) ,
.ALUSrcD(ALUSrcD) ,.RegDstD(RegDstD) ,.RegWriteD(RegWriteD)
);

//  Stimulus Block


    initial begin
        $display("==================================================");
        $display("Starting Control Unit Testbench ...");
        $display("==================================================");
        
        // --- Test Case 1: R-type (ADD) ---
        op = 6'b000000; funct = 6'b100000; #10;
        if (RegWriteD === 1 && RegDstD === 1 && ALUSrcD === 0 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b010) 
            $display("[PASS] R-type ADD Correct.");
        else 
            $display("[FAIL] R-type ADD Mismatch!");

        // --- Test Case 1.1: R-type (SUB) ---
        op = 6'b000000; funct = 6'b100010; #10;
        if (RegWriteD === 1 && RegDstD === 1 && ALUSrcD === 0 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b110)
            $display("[PASS] R-type SUB Correct.");
        else
            $display("[FAIL] R-type SUB Mismatch!");

        // --- Test Case 1.2: R-type (AND) ---
        op = 6'b000000; funct = 6'b100100; #10;
        if (RegWriteD === 1 && RegDstD === 1 && ALUSrcD === 0 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b000)
            $display("[PASS] R-type AND Correct.");
        else
            $display("[FAIL] R-type AND Mismatch!");

        // --- Test Case 1.3: R-type (OR) ---
        op = 6'b000000; funct = 6'b100101; #10;
        if (RegWriteD === 1 && RegDstD === 1 && ALUSrcD === 0 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b001)
            $display("[PASS] R-type OR Correct.");
        else
            $display("[FAIL] R-type OR Mismatch!");

        // --- Test Case 1.4: R-type (SLT) ---
        op = 6'b000000; funct = 6'b101010; #10;
        if (RegWriteD === 1 && RegDstD === 1 && ALUSrcD === 0 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b111)
            $display("[PASS] R-type SLT Correct.");
        else
            $display("[FAIL] R-type SLT Mismatch!");

        // --- Test Case 1.5: R-type (Unknown Function -> Default ALU) ---
        op = 6'b000000; funct = 6'b111111; #10;
        if (RegWriteD === 1 && RegDstD === 1 && ALUSrcD === 0 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b010)
            $display("[PASS] R-type Unknown Function Default Correct.");
        else
            $display("[FAIL] R-type Unknown Function Default Mismatch!");

        // --- Test Case 2: Load Word (lw) ---
        op = 6'b100011; funct = 6'bxxxxxx; #10; 
        if (RegWriteD === 1 && RegDstD === 0 && ALUSrcD === 1 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 1 && ALUControlD === 3'b010)
            $display("[PASS] Load Word (lw) Correct.");
        else 
            $display("[FAIL] Load Word (lw) Mismatch!");

        // --- Test Case 3: Store Word (sw) ---
        op = 6'b101011; funct = 6'bxxxxxx; #10; 
        if (RegWriteD === 0 && RegDstD === 0 && ALUSrcD === 1 && BranchD === 0 && MemWriteD === 1 && MemtoRegD === 0 && ALUControlD === 3'b010)
            $display("[PASS] Store Word (sw) Correct.");
        else 
            $display("[FAIL] Store Word (sw) Mismatch!");

        // --- Test Case 4: Branch Equal (beq) ---
        op = 6'b000100; funct = 6'bxxxxxx; #10; 
        if (RegWriteD === 0 && RegDstD === 0 && ALUSrcD === 0 && BranchD === 1 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b110)
            $display("[PASS] Branch Equal (beq) Correct.");
        else
            $display("[FAIL] Branch Equal (beq) Mismatch!");

        // --- Test Case 5: Add Immediate (addi) ---
        op = 6'b001000; funct = 6'bxxxxxx; #10; 
        if (RegWriteD === 1 && RegDstD === 0 && ALUSrcD === 1 && BranchD === 0 && MemWriteD === 0 && MemtoRegD === 0 && ALUControlD === 3'b010)
            $display("[PASS] Add Immediate (addi) Correct.");
        else
            $display("[FAIL] Add Immediate (addi) Mismatch!");

        // --- Test Case 6: Illegal Opcode (Main Decoder Default Case) ---
        op = 6'b111111; funct = 6'b000000; #10;
        if (RegWriteD === 0 && MemWriteD === 0 && BranchD === 0)
            $display("[PASS] Illegal Opcode Safety Triggered.");
        else
            $display("[FAIL] Security Risk! Outputs active on illegal instruction.");

        $display("==================================================");
        $display("Testbench Finished Successfully.");
        $display("==================================================");
        $finish;
    end

endmodule

