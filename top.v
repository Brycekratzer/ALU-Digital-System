module top(
    input clk,
    input btnC, // When pressed, Do operation
    input btnU, // Resets A,B,Y values
    input sw[15:0], // sw[3:0] - Operation selector | sw[15:8] - 8-bit input
    output seg[6:0], // Display segments?
    output an[3:0],
    output led[15:0], // led[15:8] - Display A val | led[7:0] Display B
    output Y[7:0]
);

// Internal wires
wire enable = btnC;
wire reset = btnU;
wire [7:0] reg_A_out, reg_B_out, reg_Y_out;

wire [7:0] operation_result;
wire div_clock;

clock_div clk_div(
    .clock(clk),
    .reset(enable),
    .div_clock(div_clock)
);

opermux demux(
    .data_in(sw[15:8]),
    .selector(sw[3:0]),
    .clock(div_clock),
    .reset(reset),
    .enable(enable),
    .Y(reg_Y_out),
    .ALed(led[15:8]),
    .BLed(led[7:0])
);






    
endmodule