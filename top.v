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

// Arithmetic Operations
wire [7:0] ADD;    // Addition
wire [7:0] SUB;    // Subtraction
wire [7:0] NEG;    // Two's Complement

// Shift Operations
wire [7:0] SHL;    // Shift Left
wire [7:0] SHR;    // Shift Right

// Comparison
wire [7:0] CMP;    // Compare A and B

// Logic Operations
wire [7:0] AND;    // Bitwise AND
wire [7:0] OR;     // Bitwise OR
wire [7:0] XOR;    // Bitwise XOR
wire [7:0] NAND;   // Bitwise NAND
wire [7:0] NOR;    // Bitwise NOR
wire [7:0] XNOR;   // Bitwise XNOR
wire [7:0] INV;    // Bitwise NOT (Invert)

// Data Movement Operations
wire [7:0] STO;    // Store to A
wire [7:0] SWP;    // Swap A and B
wire [7:0] LOAD;   // Load from input

// Tempory A and B
wire [7:0] A;
wire [7:0] B;

// Register Here

// Multiplexor for the output operation
opermux operselect(
    // Operation Results
    .ADD(ADD),      // Result from adder
    .SUB(SUB),      // Result from subtractor
    .SHL(SHL),      // Result from shift left
    .SHR(SHR),      // Result from shift right
    .CMP(CMP),      // Result from comparator
    .AND(AND),      // Result from AND
    .OR(OR),        // Result from OR
    .XOR(XOR),      // Result from XOR
    .NAND(NAND),    // Result from NAND
    .NOR(NOR),      // Result from NOR
    .XNOR(XNOR),    // Result from XNOR
    .INV(INV),      // Result from NOT
    .NEG(NEG),      // Result from Two's Complement
    .STO(STO),      // Result from Store operation
    .SWP(SWP),      // Result from Swap operation
    .LOAD(LOAD),    // Result from Load operation
    .A(A),
    .B(B),
    .Sel(sw[3:0]),
    .Y(Y)
);

// Need to implement the following:
// - Blank Register for A and B
// - Button that, when hit, goes through with the operation 
// - displays on seven segment
// - Reset


// NOTES:  Start with 2 registers, A[7:0] and B[7:0]. These will need to be reset using btnU
    
endmodule