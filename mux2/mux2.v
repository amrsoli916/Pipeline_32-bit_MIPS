module mux2 #( parameter WIDTH = 32)
 (
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    input              sel,

    output reg [WIDTH-1:0] y
);

always @(*) 
begin
    if (sel)
        y = b;
    else
        y = a;
end
endmodule