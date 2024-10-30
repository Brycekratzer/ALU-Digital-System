module top(
    input clk,
    input btnC, // When pressed, Do operation
    input btnU, // Resets A,B,Y values
    input sw[15:0], //sw[3:0] - Operation selector | sw[15:8] - 8-bit input
    output seg[6:0], // Display segments?
    output an[3:0]
    output led[15:0], //led[15:8] - Display A val | led[7:0] Display B
    output Y[7:0]
);

// IDEA : implement a demux to control how we will operate on A and B.
//      | input = sw[15:8]
//      | switch = sw[3:0]
//      | output = specified operation
//
// IDEA : may need too look at lab week 09 for storing bits when LOAD is used

// NOTES:  Start with 2 registers, A[7:0] and B[7:0]. These will need to be reset using btnU
    
endmodule