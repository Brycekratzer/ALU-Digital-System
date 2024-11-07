module top(
    input clk,
    input btnC,              // When pressed, Do operation
    input btnU,              // Resets A, B, Y values
    input [15:0] sw,         // 16-bit switch input; sw[3:0] for operation, sw[15:8] for 8-bit data input
    output [6:0] seg,        // 7-segment display output
    output [3:0] an,         // Anode control for 7-segment display
    output [15:0] led,       // LED display; led[15:8] for A, led[7:0] for B
    output [7:0] Y           // Output for ALU result
);

// Internal wires
wire enable = btnC;
wire reset = btnU;
wire [7:0] reg_A_out, reg_B_out, reg_Y_out;
wire [7:0] operation_result;
wire div_clock;

// Instantiate clock divider
clock_div clk_div(
    .clock(clk),
    .reset(enable),
    .div_clock(div_clock)
);

// Instantiate the operation multiplexer (opermux)
opermux demux(
    .data_in(sw[15:8]),
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
    .anode(an)
);

// Instantiate the seven-segment decoder
seven_seg_decoder decoder(
    .YInput(reg_Y_out),
    .anode(an),
    .operation(sw[3:0]),
    .segs(seg)
);

endmodule

