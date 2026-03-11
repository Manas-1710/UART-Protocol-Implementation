module uart_top_tb;

reg clk, rst;
reg [7:0] data_in;
reg wr_en;
reg rdy_clr;

wire rdy;
wire [7:0] data_out;
wire busy;

top dut(
    rst,
    wr_en,
    clk,
    rdy_clr,
    data_in,
    rdy,
    busy,
    data_out
);

initial begin
    $dumpfile("uart1.vcd");
    $dumpvars(0, uart_top_tb);

    clk = 0;
    rst = 0;
    wr_en = 0;
    rdy_clr = 0;
    data_in = 0;

    rst = 1;
    #20;
    rst = 0;

    #50;
end

always #10 clk = ~clk;

task send_byte(input [7:0] din);
begin
    @(negedge clk);
    data_in = din;
    wr_en = 1'b1;

    @(negedge clk);
    wr_en = 0;
end
endtask

task clear_ready;
begin
    @(negedge clk)
        rdy_clr = 1;

    @(negedge clk)
        rdy_clr = 0;
end
endtask

initial begin

    send_byte(8'h41);
    wait(!busy);
    wait(rdy);
    $display("received data is %h", data_out);
    clear_ready;

    send_byte(8'h55);
    wait(!busy);
    wait(rdy);
    $display("received data is %h", data_out);
    clear_ready;

    #500000;
    $finish;

end

endmodule
