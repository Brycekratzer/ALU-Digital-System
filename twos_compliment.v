module twos_compliment(
    input [7:0] A,B,
    output [7:0] Y
);

wire [7:0] carry;  // Define all carries at once

genvar i;
generate
    for(i = 0; i < 8; i = i + 1) begin : lower_bits
        full_adder add(
            .A(A[i]),
            .B(B[i]),
            .Cin(i == 0 ? 1'b0 : carry[i-1]),  // Condition for first bit carry in.
            .Y(Y[i]),
            .Cout(carry[i])
        );
    end
endgenerate

endmodule