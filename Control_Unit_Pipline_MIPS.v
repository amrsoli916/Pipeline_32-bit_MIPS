module Control_Unit_Pipeline_MIPS (
    // inputs
    input wire [5:0] funct,
    input wire [5:0] op,
    // outputs
    output reg       MemtoRegD,
    output reg       MemWriteD,
    output reg       BranchD,
    output reg [2:0] ALUControlD,
    output reg       ALUSrcD,
    output reg       RegDstD,
    output reg       RegWriteD
    // output reg       JumpD ..... if we add jump 
);

reg [1:0] alu_op;

always @(*) begin
    case (op)
        6'b000000 : begin RegWriteD=1; RegDstD=1; ALUSrcD=0; BranchD=0; MemWriteD=0; MemtoRegD=0; alu_op=2'b10; end // R-type
        6'b100011 : begin RegWriteD=1; RegDstD=0; ALUSrcD=1; BranchD=0; MemWriteD=0; MemtoRegD=1; alu_op=2'b00; end // lw
        6'b101011 : begin RegWriteD=0; RegDstD=0; ALUSrcD=1; BranchD=0; MemWriteD=1; MemtoRegD=0; alu_op=2'b00; end // sw
        6'b000100 : begin RegWriteD=0; RegDstD=0; ALUSrcD=0; BranchD=1; MemWriteD=0; MemtoRegD=0; alu_op=2'b01; end // beq
        6'b001000 : begin RegWriteD=1; RegDstD=0; ALUSrcD=1; BranchD=0; MemWriteD=0; MemtoRegD=0; alu_op=2'b00; end // addi
        // 6'b000010 : begin RegWriteD=0; RegDstD=0; ALUSrcD=0; BranchD=0; MemWriteD=0; MemtoRegD=0; alu_op=2'b00; JumpD=1; end // j ..... if we add jump 
        default   : begin RegWriteD=0; RegDstD=0; ALUSrcD=0; BranchD=0; MemWriteD=0; MemtoRegD=0; alu_op=2'b00; end
    endcase
end

always @(*) begin
    casex({alu_op , funct})
        8'b00_xxxxxx : ALUControlD = 3'b010; // add
        8'bx1_xxxxxx : ALUControlD = 3'b110; // subtract
        8'b1x_100000 : ALUControlD = 3'b010; // add
        8'b1x_100010 : ALUControlD = 3'b110; // subtract
        8'b1x_100100 : ALUControlD = 3'b000; // and
        8'b1x_100101 : ALUControlD = 3'b001; // or
        8'b1x_101010 : ALUControlD = 3'b111; // set less than
        default      : ALUControlD = 3'b010; // default
    endcase
end

endmodule