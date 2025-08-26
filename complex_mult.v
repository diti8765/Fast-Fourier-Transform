module complex_mult(
    input signed [15:0] a, b,
    output signed [15:0] prod
);
    wire signed [7:0] a_real = a[15:8];
    wire signed [7:0] a_imag = a[7:0];
    wire signed [7:0] b_real = b[15:8];
    wire signed [7:0] b_imag = b[7:0];

    wire signed [15:0] mult_rr = a_real * b_real;
    wire signed [15:0] mult_ii = a_imag * b_imag;
    wire signed [15:0] mult_ri = a_real * b_imag;
    wire signed [15:0] mult_ir = a_imag * b_real;

    wire signed [16:0] real_part = mult_rr - mult_ii;
    wire signed [16:0] imag_part = mult_ri + mult_ir;

    // Scale down result by 8 bits (right shift by 8) to keep 8-bit real & imag
    wire signed [7:0] real_scaled = real_part[15:8];
    wire signed [7:0] imag_scaled = imag_part[15:8];

    assign prod = {real_scaled, imag_scaled};
endmodule
