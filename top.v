module top(
    input clk,
    input btnC,              // When pressed, Do operation
    input btnU,              // Resets A, B, Y values
    input [15:0] sw,         // 16-bit switch input; sw[3:0] for operation, sw[15:8] for 8-bit data input
    output [6:0] seg,        // 7-segment display output
    output [3:0] an,         // Anode control for 7-segment display
    output [15:0] led        // LED display; led[15:8] for A, led[7:0] for B
);

// Internal wires
wire enable = btnC;
wire reset = btnU;
wire div_clock;
wire [7:0] reg_Y_out;
wire [7:0] data_in_top;

assign data_in_top=sw[15:8];
// Instantiate clock divider
clock_div clk_div(
    .clock(clk),
    .reset(enable),
    .div_clock(div_clock)
);

// Instantiate the operation multiplexer (opermux)
opermux demux(
    .data_in(data_in_top),
    .selector(sw[3:0]),
    .clock(div_clock),
    .reset(reset),
    .enable(enable),
    .Y(reg_Y_out),
    .ALed(led[15:8]),       // Connect A output to led[15:8]
    .BLed(led[7:0])         // Connect B output to led[7:0]
);

// Instantiate the seven-segment display scanner
seven_seg_scanner scanner(
    .div_clock(div_clock),
    .reset(reset),
    .anode(an[3:0])
);

// Instantiate the seven-segment decoder
seven_seg_decoder decoder(
    .YInput(reg_Y_out),
    .anode(an[3:0]),
    .operation(sw[3:0]),
    .segs(seg[6:0])
);

endmodule

