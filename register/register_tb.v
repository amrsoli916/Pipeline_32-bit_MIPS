`timescale 1ns/1ps
module register_tb;

parameter WIDTH = 32;

reg                  clk;
reg                  en;
reg                  clr;
reg  [WIDTH-1:0]     d;

wire [WIDTH-1:0]     q;

// DUT
register #(
    .WIDTH(WIDTH)
) DUT (
    .clk(clk),
    .en(en),
    .clr(clr),
    .d(d),
    .q(q)
);

// Clock Generation
always #5 clk = ~clk;

initial 
begin

    clk = 0;
    en  = 0;
    clr = 1;
    d   = 32'h12345678;

    // Case 1: Clear register

    #10;

    // Case 2: Load first value

    clr = 0;
    en  = 1;
    d   = 32'h11111111;
    #10;

    // Case 3: Load another value

    d = 32'hAAAAAAAA;
    #10;

    // Case 4: Disable enable

    en = 0;
    d  = 32'h55555555;
    #10;

    // Case 5: Enable again

    en = 1;
    #10;

    // Case 6: Clear while running

    clr = 1;
    #10;

    // Case 7: Load after clear

    clr = 0;
    d   = 32'hCAFEBABE;
    #10;

    $stop;

end
endmodule