module opermux(
    input [7:0] data_in,       // Signed 8-bit input data for loading or storing in A
    input [3:0] selector,      // 4-bit selector for ALU operation
    input clock,           // Clock input for registers and ALU operations
    input reset,               
    input enable,              // Enable signal for registers
    output reg [7:0] Y,        // Signed 8-bit output for result
    output [7:0] ALed,         // LED output for register A
    output [7:0] BLed          // LED output for register B
);

wire [7:0] A, B;               // Define A and B as wires for continuous assignment
reg [7:0] tmp;                 // Temporary register for swapping
wire [7:0] A_twoscomp, A_add, A_sub;

// Connect ALed and BLed directly to internal registers A and B
assign ALed = A;
assign BLed = B;

// Register instances (connected to A and B as wires)
register_8bit regA (
    .clk(div_clock),
    .reset(reset),
    .enable(enable && (selector == 4'b1111)),  // Enable only for Load A
    .data_in(data_in),    
    .data_out(A)
);

register_8bit regB (
    .clk(div_clock),
    .reset(reset),
    .enable(1'b0),             // B is not directly loaded from data_in
    .data_in(8'b0),            // B only updates through swapping
    .data_out(B)
);

// Instantiate additional operation modules
twos_compliment Atwo (
    .A(A),
    .Y(A_twoscomp)
);

adder add (
    .A(A),
    .B(B),                    
    .Y(A_add)
);

subtract sub (
    .A(A),
    .B(B),                   
    .Y(A_sub)
);

// Reset all registers to zero
always @(posedge reset) begin
    Y <= 8'sd0;
end

// ALU operation based on selector
always @(posedge div_clock) begin
    if (enable) begin
        case(selector)
            4'b0000: Y = A_add;            // Addition          
            4'b0001: Y = A_sub;            // Subtraction                         
            4'b0010: Y = A << 1;           // Shift left   
            4'b0011: Y = A >> 1;           // Shift right   
            4'b0100: begin                 // Comparison        
                if (A == B) 
                    Y = 8'sd0;            
                else if (A > B) 
                    Y = 8'sd1;           
                else 
                    Y = -8'sd1;           
            end
            4'b0101: Y = A & B;            // Bitwise AND
            4'b0110: Y = A | B;            // Bitwise OR
            4'b0111: Y = A ^ B;            // Bitwise XOR
            4'b1000: Y = ~(A & B);         // Bitwise NAND
            4'b1001: Y = ~(A | B);         // Bitwise NOR
            4'b1010: Y = ~(A ^ B);         // Bitwise XNOR
            4'b1011: Y = ~A;               // Bitwise NOT
            4'b1100: Y = A_twoscomp;       // Two's Complement (Negate A)
            4'b1101: tmp = Y;              // Store Y in A; here, tmp holds the value for further use
            4'b1110: begin                 // Swap A and B
                tmp = A;
                Y = B;
            end
            4'b1111: Y = data_in;          // Load data_in into A directly
            default: Y = 8'sd0;
        endcase
    end
end

endmodule