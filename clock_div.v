module dff(
    input reset,
    input clock,
    input D,
    output reg Q,
    output NotQ
);

    always @(posedge reset, posedge clock) begin
        if (reset) begin
            Q <= 0;
        end else begin
            Q <= D;
        end
    end
    assign NotQ = ~Q;
endmodule

module clock_div
#(
    parameter DIVIDE_BY = 17 // Or 100,000 for counter implementation
)
(
    input clock,
    input reset,
    output reg div_clock // Slowed down clock
);
wire [DIVIDE_BY:0]clock_out;
wire [DIVIDE_BY:1]Din;

dff ddflip(
    .reset(reset),
    .clock(clock),
    .D(Din[0]),
    .Q(clock_out[0])
);
// synchronous logic block, sensitive to rising edge of clock or reset


assign Din = ~clock_out;

genvar i;
generate
    for(i = 1; i < DIVIDE_BY; i = i + 1)begin
        dff ddflip(
            .reset(reset),
            .clock(clock_out[i-1]),
            .D(Din[i]),
            .Q(clock_out[i])
        );
    end
endgenerate
always@(*)begin
    div_clock = clock_out[DIVIDE_BY-1];
end

endmodule