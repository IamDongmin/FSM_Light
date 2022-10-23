`timescale 1ns / 1ps

module top_ledLight(
    input i_clk,
    input i_reset,
    input i_button0, i_button1,

    output [1:0] o_light
    );

    wire w_button0, w_button1;

    ButtonController btnctrl0(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button0),
        .o_button(w_button0)
    );

    ButtonController btnctrl1(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button1),
        .o_button(w_button1)
    );

    FSM_Light ledLight(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button0(w_button0),
        .i_button1(w_button1),
        .o_light(o_light)
    );


endmodule
