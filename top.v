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

// Register control enables
wire enable_A, enable_B, enable_Y;

// Arithmetic operation enables
wire enable_add;
wire enable_sub;
wire enable_shl;
wire enable_shr;

// Comparison enable
wire enable_cmp;

// Logic operation enables
wire enable_and;
wire enable_or;
wire enable_xor;
wire enable_nand;
wire enable_nor;
wire enable_xnor;
wire enable_not;

// Special operation enables
wire enable_neg;    // Two's complement
wire enable_sto;    // Store Y to A
wire enable_swp;    // Swap A and B
wire enable_load;   // Load from switches to A

wire [7:0] operation_result;
wire div_clock;

clock_div clk_div(
    .clock(clk),
    .reset(enable),
    .div_clock(div_clock)
);

// Instantiate controller
alu_controller controller (
    .clk(div_clock),
    .reset(reset),
    .btn_execute(btn_execute),
    .operation(sw[3:0]),
    
    // Register enables
    .enable_A(enable_A),
    .enable_B(enable_B),
    .enable_Y(enable_Y),
    
    // Arithmetic operation enables
    .enable_add(enable_add),
    .enable_sub(enable_sub),
    .enable_shl(enable_shl),
    .enable_shr(enable_shr),
    
    // Comparison enable
    .enable_cmp(enable_cmp),
    
    // Logic operation enables
    .enable_and(enable_and),
    .enable_or(enable_or),
    .enable_xor(enable_xor),
    .enable_nand(enable_nand),
    .enable_nor(enable_nor),
    .enable_xnor(enable_xnor),
    .enable_not(enable_not),
    
    // Special operation enables
    .enable_neg(enable_neg),
    .enable_sto(enable_sto),
    .enable_swp(enable_swp),
    .enable_load(enable_load)
);



// Instantiate registers
register_8bit reg_A (
    .clk(div_clock),
    .reset(reset),
    .enable(enable_A),
    .data_in(sw[15:8]),
    .data_out(reg_A_out[7:0])
);

register_8bit reg_B (
    .clk(div_clock),
    .reset(reset),
    .enable(enable_B),
    .data_in(sw[15:8]),
    .data_out(reg_B_out)
);

adder alu_add (
    .A(reg_A_out[7:0]),
    .B(reg_B_out[7:0]),
    .E(enable_add),
    .Y(operation_result[7:0])
);

subtract alu_sub (
    .A(reg_A_out[7:0]),
    .B(reg_B_out[7:0]),
    .E(enable_sub),
    .Y(operation_result[7:0])
);

register_8bit reg_Y (
    .clk(clk),
    .reset(reset),
    .enable(enable_Y),
    .data_in(operation_result[7:0]),
    .data_out(reg_Y_out[7:0])
);

// Output assignments
assign led_A = reg_A_out[7:0];
assign led_B = reg_B_out[7:0];

// clock_div clk_div(
//     .clock(div_clock),
//     .reset(enable),
//     .div_clock(div_clock)
// );

// seven_seg_scanner seven_scan(
//     .div_clock(div_clock),
//     .reset(reset),
//     .anode(an[3:0])
// );
// seven_seg_decoder decoderSeg(
//     .anode(an[3:0]),
//     .YInput(Yinput[7:0]),
//     .segs(seg[6:0]),
//     .operation(sw[3:0])
// );
    
endmodule