module alu_controller (
    input clk,
    input reset,
    input btn_execute,
    input [3:0] operation,
    output reg enable_A,
    output reg enable_B,
    output reg enable_Y,
    output reg enable_
    output reg [3:0] operation_select
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            enable_A <= 0;
            enable_B <= 0;
            enable_Y <= 0;
            operation_select <= 4'b0;
        end
        else if (btn_execute) begin
            case(operation)
                4'hF: begin  // LOAD
                    enable_A <= 1;
                    enable_B <= 0;
                    enable_Y <= 0;
                end
                // ... other operation controls
            endcase
        end
        else begin
            enable_A <= 0;
            enable_B <= 0;
            enable_Y <= 0;
        end
    end
endmodule