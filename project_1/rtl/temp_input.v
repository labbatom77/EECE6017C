`include "constants.h"

module temp_input(
    input rst,

    input enter,
    input [3:0] value,

    output [1:0] input_state,

    output [3:0] current_value,
    output reg [3:0] temp_value_ones = 0,
    output reg [3:0] temp_value_tens = 0,
    output reg [3:0] temp_value_huns = 0,

    output reg [3:0] temp_value_ones_old = 0,
    output reg [3:0] temp_value_tens_old = 0,
    output reg [3:0] temp_value_huns_old = 0
);

    reg [1:0] state = `INPUT_STATE_ONES;

    always @(posedge enter, posedge rst) begin
        if (rst) begin
            temp_value_ones <= 0;
            temp_value_tens <= 0;
            temp_value_huns <= 0;
            temp_value_ones_old <= 0;
            temp_value_tens_old <= 0;
            temp_value_huns_old <= 0;
        end else begin
            case (state)
                `INPUT_STATE_ONES: begin 
                    temp_value_ones <= current_value;
                    temp_value_ones_old <= temp_value_ones;
                    state <= `INPUT_STATE_TENS;
                end
                `INPUT_STATE_TENS: begin
                    temp_value_tens <= current_value;
                    temp_value_tens_old <= temp_value_tens;
                    state <= `INPUT_STATE_HUNS;
                end
                `INPUT_STATE_HUNS: begin
                    temp_value_huns <= current_value;
                    temp_value_huns_old <= temp_value_huns;
                    state <= `INPUT_STATE_DONE;
                end
                `INPUT_STATE_DONE: begin
                    state <= `INPUT_STATE_ONES;
                end
            endcase
        end
    end

    assign current_value = (value < 10) ? value : 9;

    assign input_state = state;

endmodule
