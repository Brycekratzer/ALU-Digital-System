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
wire [7:0] reg_A_out, reg_B_out, reg_Y_out;
wire enable_A, enable_B, enable_Y;
wire [7:0] operation_result;

clock_div clk_div(
    .clock(clk),
    .reset(enable),
    .div_clock(div_clock)
);

// Instantiate controller
alu_controller controller (
    .clk(clk),
    .reset(reset),
    .btn_execute(btn_execute),
    .operation(operation),
    .enable_A(enable_A),
    .enable_B(enable_B),
    .enable_Y(enable_Y)
);

// Instantiate registers
register_8bit reg_A (
    .clk(clk),
    .reset(reset),
    .enable(enable_A),
    .data_in(data_in),
    .data_out(reg_A_out)
);

register_8bit reg_B (
    .clk(clk),
    .reset(reset),
    .enable(enable_B),
    .data_in(data_in),
    .data_out(reg_B_out)
);

// Instantiate operation modules
adder alu_add (
    .A(reg_A_out),
    .B(reg_B_out),
    .Y(add_result)
);

// ... other operation modules

// Output assignments
assign led_A = reg_A_out;
assign led_B = reg_B_out;

clock_div clk_div(
    .clock(clk),
    .reset(enable),
    .div_clock(div_clock)
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
);
    
endmodule