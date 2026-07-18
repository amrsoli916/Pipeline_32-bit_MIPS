`timescale 1ns/1ps
module mux4_tb;

parameter WIDTH = 32;

reg  [WIDTH-1:0] in0;
reg  [WIDTH-1:0] in1;
reg  [WIDTH-1:0] in2;
reg  [WIDTH-1:0] in3;
reg  [1:0]       sel;

wire [WIDTH-1:0] out;

// Device Under Test (DUT)
mux4 #(
    .WIDTH(WIDTH)
) DUT (
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .sel(sel),
    .out(out)
);

initial
 begin

    // Case 1: Select input0 , out = in0
    
    in0 = 32'h11111111;
    in1 = 32'h22222222;
    in2 = 32'h33333333;
    in3 = 32'h44444444;

    sel = 2'b00;
    #10;

    // Case 2: Select input1 , out = in1
   
    sel = 2'b01;
    #10;

    // Case 3: Select input2 , out = in2
    
    sel = 2'b10;
    #10;

    // Case 4: Select input3 , out = in3

    sel = 2'b11;
    #10;

    // Case 5: Change selected input while sel = 2'b10 , out = in2 only
   
    sel = 2'b10;

    in2 = 32'hAAAAAAAA;
    #10;

    in2 = 32'h55555555;
    #10;

    // Case 6: Toggle select signal , out changes according to sel
  
    in0 = 32'h00000000;
    in1 = 32'h11111111;
    in2 = 32'h22222222;
    in3 = 32'h33333333;

    sel = 2'b00; #5;
    sel = 2'b01; #5;
    sel = 2'b10; #5;
    sel = 2'b11; #5;

    $stop;

end
endmodule