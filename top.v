module top(
    input clk,
    input btnC, // When pressed, Do operation
    input btnU, // Resets A,B,Y values
    input sw[15:0], // sw[3:0] - Operation selector | sw[15:8] - 8-bit input
    output seg[6:0], // Display segments?
    output an[3:0]
    output led[15:0], // led[15:8] - Display A val | led[7:0] Display B
    output Y[7:0]
);

wire enable = btnC;
wire reset = btnU;
wire div_clock;
wire [7:0] Yinput;


clock_div  clk_div(
    .clock(clk),
    .reset(enable),
    .div_clock(div_clock)
);

// Multiplexor for the output operation
opermux operselect(
    .data_in(sw[15:8]),
    .selector(sw[3:0]),
    .reset(reset),
    .enable(enable)
    .Y(Yinput[7:0]),
    .ALed(led[15:8]),
    .BLed(led[7:0]),
);

seven_seg_scanner seven_scan(
    .div_clock(div_clock),
    .reset(reset),
    .anode(an[3:0])
);
seven_seg_decoder decoderSeg(
    .anode(an[3:0]),
    .YInput(Yinput[7:0]),
    .segs(seg[6:0]),
    .operation(sw[3:0])
)

// Need to implement the following:
//  - 
    
endmodule