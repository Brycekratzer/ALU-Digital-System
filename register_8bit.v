module register_8bit (
    input clk,
    input reset,
    input enable,          // Enable signal for loading
    input [7:0] D,     // Input data
    output reg [7:0] Q // Output data
);
    // On every positive clock edge or reset
    always @(posedge clk or posedge rst) begin
        if (reset)
            Q <= 8'b0;    // Reset to 0
        else if (en)      // Only load when enabled
            Q <= D;       // Load new value
    end
endmodule