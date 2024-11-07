module register_8bit (
    input clk,
    input reset,
    input enable,          // When to load new value
    input [7:0] data_in,   
    output reg [7:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 8'b0;
        else if (enable)
            data_out <= data_in;
    end
endmodule