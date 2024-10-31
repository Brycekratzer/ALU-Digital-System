module opermux(
    input signed [7:0] data_in,     // Signed 8-bit input data for loading or storing in A
    input [3:0] selector,           // 4-bit selector for ALU operation
    input reset,                    // Reset signal to zero all registers
    output reg signed [7:0] Y,      // Signed 8-bit output for result
    output reg signed [7:0] ALed,   // Signed 8-bit LED output for register A
    output reg signed [7:0] BLed    // Signed 8-bit LED output for register B
);

    // Internal signed 8-bit registers
    reg signed [7:0] A;
    reg signed [7:0] B;
    reg signed [7:0] tmp;

    // Reset all registers to zero
    always @(posedge reset) begin
        A <= 8'sd0;
        B <= 8'sd0;
        Y <= 8'sd0;
    end

    // ALU operation based on selector
    always @(selector or A or B or data_in) begin
        case(selector)
            4'b0000: Y = A + B;           // Addition
            4'b0001: Y = A - B;           // Subtraction
            4'b0010: Y = A <<< 1;         // Signed shift left
            4'b0011: Y = A >>> 1;         // Signed arithmetic shift right

            4'b0100: begin                // Comparison
                if (A == B) 
                    Y = 8'sd0;            // Y = 0 if A == B
                else if (A > B) 
                    Y = 8'sd1;            // Y = 1 if A > B
                else 
                    Y = -8'sd1;           // Y = -1 if A < B
            end
            
            4'b0101: Y = A & B;           // Bitwise AND
            4'b0110: Y = A | B;           // Bitwise OR
            4'b0111: Y = A ^ B;           // Bitwise XOR
            4'b1000: Y = ~(A & B);        // Bitwise NAND
            4'b1001: Y = ~(A | B);        // Bitwise NOR
            4'b1010: Y = ~(A ^ B);        // Bitwise XNOR
            4'b1011: Y = ~A;              // Bitwise NOT
            4'b1100: Y = -A;              // Two's Complement (Negate A)
            4'b1101: A = Y;               // Store Y in A
            4'b1110: begin                // Swap A and B
                tmp = A;
                A = B;
                B = tmp;
            end
            4'b1111: A = data_in;         // Load data_in into A
            default: Y = 8'sd0;           // Default case (optional)
        endcase

        // Reflect A and B on ALed and BLed
        ALed = A;
        BLed = B;
    end
endmodule