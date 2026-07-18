`timescale 1ns/1ps
module adder_tb;

parameter WIDTH = 32;

reg  [WIDTH-1:0] A;
reg  [WIDTH-1:0] B;

wire [WIDTH-1:0] SUM;

// instantiation
adder #(
    .WIDTH(WIDTH)
) DUT (
    .A(A),
    .B(B),
    .SUM(SUM)
);

initial 
begin

    // Case 1 : 0 + 0
    A = 32'h00000000;
    B = 32'h00000000;
    #10;

    // Case 2 : Normal Addition
    A = 32'h00000005;
    B = 32'h00000003;
    #10;

    // Case 3 : Hex Numbers
    A = 32'h11111111;
    B = 32'h22222222;
    #10;

    // Case 4 : Maximum Value + 1
    A = 32'hFFFFFFFF;
    B = 32'h00000001;
    #10;

    // Case 5 : Random Values
    A = 32'h12345678;
    B = 32'h87654321;
    #10;

    $stop;

end
endmodule