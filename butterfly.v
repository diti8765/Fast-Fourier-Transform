module butterfly(
    input signed [15:0] x0, x1,
    input signed [15:0] twiddle,
    output signed [15:0] y0, y1
);
    wire signed [15:0] temp_sub;

    complex_add add_inst (.a(x0), .b(x1), .sum(y0));
    complex_sub sub_inst (.a(x0), .b(x1), .diff(temp_sub));
    complex_mult mult_inst (.a(temp_sub), .b(twiddle), .prod(y1));
endmodule
