module math_block(
    input [3:0] A,
    input [3:0] B,
    output reg [3:0] AplusB,
    output reg [3:0] AminusB
);  
    always @(*) begin
        AplusB = A + B;
        AminusB = A - B;
    end


endmodule


