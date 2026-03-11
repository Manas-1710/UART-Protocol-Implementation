module receiver(
    input clk,
    input rst,
    input rx,
    input rdy_clr,
    input en,
    output reg rdy,
    output reg [7:0] data_out
);

parameter start_state = 2'b00;
parameter data_state  = 2'b01;
parameter stop_state  = 2'b10;

reg [1:0] state;
reg [3:0] sample;
reg [2:0] index;
reg [7:0] temp_register;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= start_state;
        sample <= 0;
        index <= 0;
        temp_register <= 0;
        rdy <= 0;
        data_out <= 0;
    end
    else
    begin
        if(rdy_clr)
            rdy <= 0;

        if(en)
        begin
            case(state)

            start_state:
            begin
                if(rx == 0)
                    sample <= sample + 1;
                else
                    sample <= 0;

                if(sample == 15)
                begin
                    state <= data_state;
                    sample <= 0;
                    index <= 0;
                end
            end

            data_state:
            begin
                sample <= sample + 1;

                if(sample == 8)
                    temp_register[index] <= rx;

                if(sample == 15)
                begin
                    sample <= 0;

                    if(index == 7)
                        state <= stop_state;
                    else
                        index <= index + 1;
                end
            end

            stop_state:
            begin
                sample <= sample + 1;

                if(sample == 15)
                begin
                    state <= start_state;
                    data_out <= temp_register;
                    rdy <= 1'b1;
                    sample <= 0;
                end
            end

            default:
                state <= start_state;

            endcase
        end
    end
end

endmodule
