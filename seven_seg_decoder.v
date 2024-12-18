module seven_seg_decoder(
    input [7:0] YInput,
    input [3:0] operation,
    input [3:0] an,
    output reg [6:0] segs
);

    reg [3:0] A;
    reg [3:0] B;
    reg [3:0] selected_sig;

    // Assign the lower and upper 4 bits of YInput to A and B, respectively
    always @(*) begin
        A = YInput[3:0];
        B = YInput[7:4];
    end

    // Select the signal based on the an value
    always @(*) begin
        case (an)
            4'b1110: selected_sig = operation;       // Display Operation Num
            4'b1101: selected_sig = 4'b0000;         // Display B
            4'b1011: selected_sig = A;               // Display Lower 4 bits
            4'b0111: selected_sig = B;               // Display Upper 4 bits
            default: selected_sig = 4'b0000;         // Default case to prevent latches
        endcase
    end

    // Decode the selected signal to the seven-segment display
    always @(*) begin
        case(selected_sig)
            4'd0: segs = 7'b1000000;  // 0
            4'd1: segs = 7'b1111001;  // 1
            4'd2: segs = 7'b0100100;  // 2
            4'd3: segs = 7'b0110000;  // 3
            4'd4: segs = 7'b0011001;  // 4
            4'd5: segs = 7'b0010010;  // 5
            4'd6: segs = 7'b0000010;  // 6
            4'd7: segs = 7'b1111000;  // 7
            4'd8: segs = 7'b0000000;  // 8
            4'd9: segs = 7'b0010000;  // 9
            4'd10: segs = 7'b0001000; // A
            4'd11: segs = 7'b0000011; // B
            4'd12: segs = 7'b1000110; // C
            4'd13: segs = 7'b0100001; // D
            4'd14: segs = 7'b0000110; // E
            4'd15: segs = 7'b0001110; // F
            default: segs = 7'b1111111; // All segments off (optional)
        endcase
    end

endmodule