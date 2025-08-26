`timescale 1ns/1ps

module fft8_tb;

    reg clk;
    reg rst;
    reg start;
    reg signed [15:0] data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, data_in6, data_in7;
    wire signed [15:0] data_out0, data_out1, data_out2, data_out3, data_out4, data_out5, data_out6, data_out7;
    wire done;

    fft8_top dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in0(data_in0),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_in4(data_in4),
        .data_in5(data_in5),
        .data_in6(data_in6),
        .data_in7(data_in7),
        .data_out0(data_out0),
        .data_out1(data_out1),
        .data_out2(data_out2),
        .data_out3(data_out3),
        .data_out4(data_out4),
        .data_out5(data_out5),
        .data_out6(data_out6),
        .data_out7(data_out7),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; start = 0;

        #20; rst = 0; #10;

        data_in0 = 16'h0100;
        data_in1 = 16'h0200;
        data_in2 = 16'h0300;
        data_in3 = 16'h0400;
        data_in4 = 16'h0500;
        data_in5 = 16'h0600;
        data_in6 = 16'h0700;
        data_in7 = 16'h0800;

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #10;
        $display("FFT Done. Outputs:");
        $display("data_out0 = %h", data_out0);
        $display("data_out1 = %h", data_out1);
        $display("data_out2 = %h", data_out2);
        $display("data_out3 = %h", data_out3);
        $display("data_out4 = %h", data_out4);
        $display("data_out5 = %h", data_out5);
        $display("data_out6 = %h", data_out6);
        $display("data_out7 = %h", data_out7);
        #10;
        $finish;
    end

    initial begin
        $dumpfile("fft8_tb.vcd");
        $dumpvars(0, fft8_tb);
        $dumpvars(1, fft8_tb.dut);
    end

endmodule
