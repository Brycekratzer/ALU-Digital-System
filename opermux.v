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



reg [7:0] A, B;               // Define A and B as wires for continuous assignment
reg [7:0] tmp;                 // Temporary register for swapping
wire [7:0] A_twoscomp, A_add, A_sub;

// Connect ALed and BLed directly to internal registers A and B
assign ALed = A;
assign BLed = B;

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

// ALU operation based on selector
always @(posedge enable, posedge reset) begin
    if (reset) begin
         Y <= 8'd0;
         A <= 8'd0;
         B <= 8'd0;
        
    end
    else begin
        case(selector)
            4'b0000: Y <= A_add;            // Addition          
            4'b0001: Y <= A_sub;            // Subtraction                         
            4'b0010: Y <= A << 1;           // Shift left   
            4'b0011: Y <= A >> 1;           // Shift right   
            4'b0100: begin                 // Comparison        
                if (A == B) 
                    Y <= 8'd0;            
                else if (A > B) 
                    Y <= 8'd1;           
                else 
                    Y <= 8'd1;           
            end
            4'b0101: Y <= A & B;            // Bitwise AND
            4'b0110: Y <= A | B;            // Bitwise OR
            4'b0111: Y <= A ^ B;            // Bitwise XOR
            4'b1000: Y <= ~(A & B);         // Bitwise NAND
            4'b1001: Y <= ~(A | B);         // Bitwise NOR
            4'b1010: Y <= ~(A ^ B);         // Bitwise XNOR
            4'b1011: Y <= ~A;               // Bitwise NOT
            4'b1100: Y <= A_twoscomp;       // Two's Complement (Negate A)
            4'b1101: A <= Y;              // Store Y in A; here, tmp holds the value for further use
            4'b1110: begin                 // Swap A and B
                B <= A;
                A <= B;
 
            end
            4'b1111: A <= data_in;          // Load data_in into A directly
            default: Y <= 8'd0;
        endcase
    end
end

endmodule