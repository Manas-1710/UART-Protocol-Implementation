module top(
    input rst,
    input wr_en,
    input clk,
    input rdy_clr,
    input [7:0] data_in,
    output rdy,
    output busy,
    output [7:0] data_out
);

wire rx_clk_en;
wire tx_clk_en;
wire tx_temp;

baud_rate_generator bg(
    clk,
    rst,
    tx_clk_en,
    rx_clk_en
);

transmitter tr(
    clk,
    wr_en,
    rst,
    tx_clk_en,
    data_in,
    tx_temp,
    busy
);

receiver re(
    clk,
    rst,
    tx_temp,
    rdy_clr,
    rx_clk_en,
    rdy,
    data_out
);

endmodule
