module complex_add(
    input signed [15:0] a, b,
    output signed [15:0] sum
);
    wire signed [7:0] a_real = a[15:8];
    wire signed [7:0] a_imag = a[7:0];
    wire signed [7:0] b_real = b[15:8];
    wire signed [7:0] b_imag = b[7:0];

    wire signed [8:0] real_sum = a_real + b_real;
    wire signed [8:0] imag_sum = a_imag + b_imag;

    assign sum = {real_sum[7:0], imag_sum[7:0]};
endmodule
 