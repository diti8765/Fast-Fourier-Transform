module twiddle_rom(
    input [2:0] addr,
    output reg signed [15:0] twiddle
);

    always @(*) begin
        case(addr)
            3'd0: twiddle = 16'h8000; // 1 + j0
            3'd1: twiddle = 16'h5AA6; // 0.7071 - j0.7071
            3'd2: twiddle = 16'h0080; // 0 - j1
            3'd3: twiddle = 16'hA6A6; // -0.7071 - j0.7071
            3'd4: twiddle = 16'h8000; // -1 + j0 (note: -128 == 0x80 for signed 8-bit)
            3'd5: twiddle = 16'hA65A; // -0.7071 + j0.7071
            3'd6: twiddle = 16'h0080; // 0 + j1
            3'd7: twiddle = 16'h5A5A; // 0.7071 + j0.7071
            default: twiddle = 16'h0000;
        endcase
    end
endmodule
