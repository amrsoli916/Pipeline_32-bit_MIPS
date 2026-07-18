`timescale 1ns/1ps
module mux2_tb;

parameter WIDTH = 32;

reg  [WIDTH-1:0] a;
reg  [WIDTH-1:0] b;
reg              sel;

wire [WIDTH-1:0] y;

// instantiation
mux2 #( .WIDTH(WIDTH)) DUT (
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

initial begin

    //------ Case 1 : zeros vs ones ------
    a   = 32'h00000000;
    b   = 32'hFFFFFFFF;
    sel = 1'b0;
    #10;

    sel = 1'b1;
    #10;

    //------ Case 2 : Random Hex values ------    
    a   = 32'h12345678;
    b   = 32'h87654321;
    sel = 1'b0;
    #10;

    sel = 1'b1;
    #10;

    //------ Case 3 : Alternating bits ------

    a   = 32'hAAAAAAAA;
    b   = 32'h55555555;
    sel = 1'b0;
    #10;

    sel = 1'b1;
    #10;

    //------ Case 4 : Same values ------
   
    a   = 32'hCAFEBABE;
    b   = 32'hCAFEBABE;
    sel = 1'b0;
    #10;

    sel = 1'b1;
    #10;

    //------ Case 5 : Toggle sel quickly ------
    a = 32'h11111111;
    b = 32'h22222222;

    sel = 0; #5;
    sel = 1; #5;
    sel = 0; #5;
    sel = 1; #5;

    //------ Case 6 : Change inputs while sel = 0 ------

    sel = 0;

    a = 32'h00000001;
    b = 32'h00000002;
    #10;

    a = 32'h00000003;
    b = 32'h00000004;
    #10;

    //------ Case 7 : Change inputs while sel = 1------
   
    sel = 1;

    a = 32'hABCDEF01;
    b = 32'h12345678;
    #10;

    a = 32'hFFFFFFFF;
    b = 32'h00000000;
    #10;

    $stop;

end
endmodule