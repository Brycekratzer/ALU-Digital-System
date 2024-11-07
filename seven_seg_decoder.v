
module seven_seg_decoder(
    input [7:0] YInput,
    input [3:0] operation,
    input [3:0] anode,
    output reg [6:0] segs
);

    reg [3:0] A = YInput[3:0];
    reg [7:4] B = YInput[7:4];

    // Select the signal based on the anode value
    always @(*) begin
        case (anode)
            4'b1110: selected_sig = operation;       // Display A
            4'b1101: selected_sig = 0000;       // Display B
            4'b1011: selected_sig = A;  // Display A + B
            4'b0111: selected_sig = B; // Display A - B
            
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
            default: segs = 7'b1111111; // All segments off (optional)xs
        endcase
    end

endmodule