module register #(parameter WIDTH = 32)
(
    input                  clk,
    input                  en,
    input                  clr,
    input  [WIDTH-1:0]     d,

    output reg [WIDTH-1:0] q
);

always @(posedge clk) begin

    if (clr)
        q <= {WIDTH{1'b0}};

    else if (en)
        q <= d;

end
endmodule