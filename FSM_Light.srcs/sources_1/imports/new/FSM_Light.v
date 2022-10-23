`timescale 1ns / 1ps

module FSM_Light(
    input i_clk,
    input i_reset,
    input i_button0, i_button1,

    output [1:0] o_light
    );

    parameter S_LED_00 = 2'b00,          // parameter는 C++의 enum과 같은 역할로 여러 상태를 정의 가능
              S_LED_01 = 2'b01,
              S_LED_10 = 2'b10,          // 0이나 1을 그냥 넣으면 32bit의 상수로 인식함
              S_LED_11 = 2'b11;

    reg [1:0] curState = S_LED_00, nextState = S_LED_00;             // 상태를 저장할 수 있는 값이 필요 --> register
    reg [1:0] r_light;

    assign o_light = r_light;

//상태 변경 적용 부분(Change State)
    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) curState <= S_LED_00;
        else        curState <= nextState;
    end

//이벤트 처리 부분(Process Event)
    always @(curState or i_button0 or i_button1) begin
       case (curState)
       S_LED_00 : begin
        if(i_button0)      nextState <= S_LED_11;
        else if(i_button1) nextState <= S_LED_01;
        else               nextState <= S_LED_00;
        //경우의 수를 다 지정하지 않은 조건문은 원치 않는 Latch가 발생하므로 FSM 조건을 잘 고려할 것
       end
       S_LED_01 : begin
        if(i_button0)      nextState <= S_LED_00;
        else if(i_button1) nextState <= S_LED_10;
        else               nextState <= S_LED_01;
       end
       S_LED_10 : begin
        if(i_button0)      nextState <= S_LED_01;
        else if(i_button1) nextState <= S_LED_11;
        else               nextState <= S_LED_10;
       end
       S_LED_11 : begin
        if(i_button0)      nextState <= S_LED_10;
        else if(i_button1) nextState <= S_LED_00;
        else               nextState <= S_LED_11;
       end
       endcase 
    end

//상태에 따른 동작 부분(Working on State)

    always @(curState) begin
        case (curState)
            S_LED_00 : r_light <= 2'b00;
            S_LED_01 : r_light <= 2'b01;
            S_LED_10 : r_light <= 2'b10;
            S_LED_11 : r_light <= 2'b11;
        endcase
    end

endmodule
