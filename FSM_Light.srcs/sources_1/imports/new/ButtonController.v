`timescale 1ns / 1ps

module ButtonController(
    input i_clk,
    input i_button,
    input i_reset,

    output o_button
    );

parameter PUSHED   = 1'b1,
          RELEASED = 1'b0,
          TRUE  = 1'b1,
          FALSE = 1'b0;

reg r_prevState = RELEASED;
reg r_button;

assign o_button = r_button;

    always @(posedge i_clk or posedge i_reset) begin        //Reset이 Clock 비동기화 동작 방식
    /*
        즉 always @(sensitivity list) 안에 값이 있으면 clock 비동기 방식, 값이 없으면 clock 동기방식
    */
//   always @(posedge i_clk) //Reset이 Clock 동기화 동작 방식
        if(i_reset) begin
            r_button <= RELEASED;
        end
        else begin
            if((i_button == PUSHED) && (r_prevState == RELEASED))begin
                r_prevState <= PUSHED;
                r_button <= FALSE;
            end
            else if((i_button == RELEASED) && (r_prevState == PUSHED))begin
                r_prevState <= RELEASED;
                r_button <= TRUE;
            end
            else begin
                r_button <= FALSE;
            end
        end
    end

endmodule
