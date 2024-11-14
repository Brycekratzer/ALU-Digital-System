
module seven_seg_scanner(
    input div_clock,
    input reset,
    output reg [3:0] an
);

    reg [1:0] count; 

    always @( posedge div_clock, posedge reset) begin
        if (reset) begin
            count <= 2'b00;   
        end
        else begin
            count <= count + 1'b1;  
            if (count == 2'b11) begin
                count <= 2'b00;     
            end
        end
    end

    always @(*) begin
        case (count)
            2'b00: an = 4'b1110;  // Segment 0 (Right)
            2'b01: an = 4'b1101;  // Segment 1 (Right Center)
            2'b10: an = 4'b1011;  // Segment 2 (Left Center)
            2'b11: an = 4'b0111;  // Segment 3 (Left)3 
        endcase
    end

endmodule