module temp_input_tb();

    reg rst = 0;
    reg enter = 0;
    reg [3:0] value = 0;
   
    wire [1:0] state;
    wire [3:0] current_value;
    wire [3:0] temp_value_ones;
    wire [3:0] temp_value_tens;
    wire [3:0] temp_value_huns;
    wire [3:0] temp_value_ones_old;
    wire [3:0] temp_value_tens_old;
    wire [3:0] temp_value_huns_old;

    temp_input uut(
        .rst(rst),
        .enter(enter),
        .value(value),
        .input_state(state),
        .current_value(current_value),
        .temp_value_ones(temp_value_ones),
        .temp_value_tens(temp_value_tens),
        .temp_value_huns(temp_value_huns),
        .temp_value_ones_old(temp_value_ones_old),
        .temp_value_tens_old(temp_value_tens_old),
        .temp_value_huns_old(temp_value_huns_old)
    );

    initial begin

        $display("state | value | c u r | o l d");
        $monitor("%d | %h | %d%d%d | %d%d%d",
            state,
            value,
            temp_value_huns,
            temp_value_tens,
            temp_value_ones,
            temp_value_huns_old,
            temp_value_tens_old,
            temp_value_ones_old
        );
       
        $display("------------------------");
        enter_value(12'h123);
        #10;
        #1 pulse_enter;
        $display("------------------------");
        enter_value(12'h555);
        #10;
        #1 pulse_enter;
        $display("------------------------");
        enter_value(12'h001);
        #10;
        #1 pulse_enter;
        $display("------------------------");
        enter_value(12'h444);
        #10;

        $finish;
    end

    task pulse_enter; begin
        #1 enter = 1; #1 enter = 0; 
    end
    endtask

    task enter_value;
        input [11:0] val;
        begin
            #1 value = val[3:0];
            #1 pulse_enter;
            #1 value = val[7:4];
            #1 pulse_enter;
            #1 value = val[11:8];
            #1 pulse_enter;
        end
    endtask

endmodule
