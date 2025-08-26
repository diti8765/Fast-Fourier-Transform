module complex_sub(
    input signed [15:0] a, b,
    output signed [15:0] diff
);
    wire signed [7:0] a_real = a[15:8];
    wire signed [7:0] a_imag = a[7:0];
    wire signed [7:0] b_real = b[15:8];
    wire signed [7:0] b_imag = b[7:0];

    wire signed [8:0] real_diff = a_real - b_real;
    wire signed [8:0] imag_diff = a_imag - b_imag;

    assign diff = {real_diff[7:0], imag_diff[7:0]};
endmodule
