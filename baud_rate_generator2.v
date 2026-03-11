module baud_rate_generator(
    input clk,
    input rst,
    output tx_enable,
    output rx_enable
);

reg [12:0] tx_counter;
reg [9:0] rx_counter;

always @(posedge clk or posedge rst)
begin
    if(rst)
        tx_counter <= 0;
    else if(tx_counter == 5208)
        tx_counter <= 0;
    else
        tx_counter <= tx_counter + 1;
end

always @(posedge clk or posedge rst)
begin
    if(rst)
        rx_counter <= 0;
    else if(rx_counter == 325)
        rx_counter <= 0;
    else
        rx_counter <= rx_counter + 1;
end

assign tx_enable = (tx_counter == 0);
assign rx_enable = (rx_counter == 0);

endmodule
