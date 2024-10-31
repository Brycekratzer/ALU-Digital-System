module opermux(
    input [7:0] ADD, SUB, SHL, SHR, CMP, AND, OR, XOR, NAND, NOR, XNOR, INV, NEG, STO, SWP, LOAD, A, B,
    input selector[3:0],
    output reg Y[7:0]
);

wire tmp [7:0];

always @(selector) begin
    case(selector)
        4'b0000: Y = ADD;    // Addition (0x0)
        4'b0001: Y = SUB;    // Subtraction (0x1)
        4'b0010: Y = A << 1;    // Shift left (0x2)
        4'b0011: Y = A >> 1;    // Shift right (0x3)
        4'b0100: Y = CMP;    // Comparison (0x4)
        4'b0101: Y = A & B;    // Bitwise AND (0x5)
        4'b0110: Y = A | B;     // Bitwise OR (0x6)
        4'b0111: Y =  A  B;    // Bitwise XOR (0x7)
        4'b1000: Y = A ~& B;   // Bitwise NAND (0x8)
        4'b1001: Y = A ~| B;    // Bitwise NOR (0x9)
        4'b1010: Y = A ~^ B;   // Bitwise XNOR (0xA)
        4'b1011: Y = ~A;    // Bitwise NOT (0xB)
        4'b1100: Y = NEG;    // Two's Complement (0xC)
        4'b1101: Y = A;    // Store A (0xD)
        4'b1110:
            tmp = A;
            A = B;
            B = tmp;
            
        4'b1111: Y =LOAD;   // Load into A (0xF)
    endcase
end
// case select or if else statments for each different operation?

endmodule

