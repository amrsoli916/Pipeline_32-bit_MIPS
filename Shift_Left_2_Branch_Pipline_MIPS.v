module Shift_Left_2_Branch_Pipline_MIPS (
    input  wire [31:0] SignImmE,
    output wire [31:0] SignImmShiftedE
);
    assign SignImmShiftedE = SignImmE << 2;

endmodule