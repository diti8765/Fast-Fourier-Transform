`timescale 1ns/1ps

module fft8_top(
    input clk,
    input rst,
    input start,
    input signed [15:0] data_in0,
    input signed [15:0] data_in1,
    input signed [15:0] data_in2,
    input signed [15:0] data_in3,
    input signed [15:0] data_in4,
    input signed [15:0] data_in5,
    input signed [15:0] data_in6,
    input signed [15:0] data_in7,
    output reg signed [15:0] data_out0,
    output reg signed [15:0] data_out1,
    output reg signed [15:0] data_out2,
    output reg signed [15:0] data_out3,
    output reg signed [15:0] data_out4,
    output reg signed [15:0] data_out5,
    output reg signed [15:0] data_out6,
    output reg signed [15:0] data_out7,
    output reg done
);

    reg [2:0] stage;
    reg [2:0] butterfly_idx;
    reg signed [15:0] ram [0:7];

    wire signed [15:0] twiddle;
    twiddle_rom twiddle_inst(.addr(butterfly_idx), .twiddle(twiddle));

    wire signed [15:0] bf_y0, bf_y1;

    butterfly bf_inst (
        .x0(ram[butterfly_idx]),
        .x1(ram[butterfly_idx + (1 << stage)]),
        .twiddle(twiddle),
        .y0(bf_y0),
        .y1(bf_y1)
    );

    reg [1:0] state;
    reg hold_done;
    localparam IDLE = 0, LOAD = 1, COMPUTE = 2, DONE = 3;

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done <= 0;
            hold_done <= 0;
            stage <= 0;
            butterfly_idx <= 0;
            for (i = 0; i < 8; i = i + 1)
                ram[i] <= 0;
            data_out0 <= 0; data_out1 <= 0; data_out2 <= 0; data_out3 <= 0;
            data_out4 <= 0; data_out5 <= 0; data_out6 <= 0; data_out7 <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    hold_done <= 0;
                    if (start) state <= LOAD;
                end

                LOAD: begin
                    ram[0] <= data_in0;
                    ram[1] <= data_in1;
                    ram[2] <= data_in2;
                    ram[3] <= data_in3;
                    ram[4] <= data_in4;
                    ram[5] <= data_in5;
                    ram[6] <= data_in6;
                    ram[7] <= data_in7;
                    stage <= 0;
                    butterfly_idx <= 0;
                    state <= COMPUTE;
                end

                COMPUTE: begin
                    ram[butterfly_idx] <= bf_y0;
                    ram[butterfly_idx + (1 << stage)] <= bf_y1;

                    if (butterfly_idx < (8 >> (stage + 1)) - 1) begin
                        butterfly_idx <= butterfly_idx + 1;
                    end else begin
                        butterfly_idx <= 0;
                        if (stage < 2) begin
                            stage <= stage + 1;
                        end else begin
                            state <= DONE;
                        end
                    end
                end

                DONE: begin
                    if (!hold_done) begin
                        data_out0 <= ram[0];
                        data_out1 <= ram[1];
                        data_out2 <= ram[2];
                        data_out3 <= ram[3];
                        data_out4 <= ram[4];
                        data_out5 <= ram[5];
                        data_out6 <= ram[6];
                        data_out7 <= ram[7];
                        done <= 1;
                        hold_done <= 1;
                    end else begin
                        done <= 0;
                        hold_done <= 0;
                        if (!start)
                            state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
