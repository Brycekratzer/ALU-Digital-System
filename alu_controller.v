module alu_controller (
    input clk,
    input reset,
    input btn_execute,
    input [3:0] operation,
    output reg enable_A,
    output reg enable_B,
    output reg enable_Y,
    output reg enable_add,
    output reg enable_sub,
    output reg enable_shl,
    output reg enable_shr,
    output reg enable_cmp,
    output reg enable_and,
    output reg enable_or,
    output reg enable_xor,
    output reg enable_nand,
    output reg enable_nor,
    output reg enable_xnor,
    output reg enable_not,
    output reg enable_neg,
    output reg enable_sto,
    output reg enable_swp,
    output reg enable_load
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all enable signals
        enable_A <= 0;
        enable_B <= 0;
        enable_Y <= 0;
        enable_add <= 0;
        enable_sub <= 0;
        enable_shl <= 0;
        enable_shr <= 0;
        enable_cmp <= 0;
        enable_and <= 0;
        enable_or <= 0;
        enable_xor <= 0;
        enable_nand <= 0;
        enable_nor <= 0;
        enable_xnor <= 0;
        enable_not <= 0;
        enable_neg <= 0;
        enable_sto <= 0;
        enable_swp <= 0;
        enable_load <= 0;
    end
    else if (btn_execute) begin
        case(operation)
            4'h0: begin  // ADD
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;  // Store result in Y
                enable_add <= 1;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h1: begin  // SUB
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;  // Store result in Y
                enable_add <= 0;
                enable_sub <= 1;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h2: begin  // SHL
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 1;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h3: begin  // SHR
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 1;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h4: begin  // CMP
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 1;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h5: begin  // AND
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 1;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h6: begin  // OR
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 1;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h7: begin  // XOR
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 1;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h8: begin  // NAND
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 1;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'h9: begin  // NOR
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 1;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'hA: begin  // XNOR
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 1;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'hB: begin  // NOT
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 1;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'hC: begin  // NEG (Two's Complement)
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 1;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 1;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'hD: begin  // STO (Store Y in A)
                enable_A <= 1;
                enable_B <= 0;
                enable_Y <= 0;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 1;
                enable_swp <= 0;
                enable_load <= 0;
            end
            
            4'hE: begin  // SWP (Swap A and B)
                enable_A <= 1;
                enable_B <= 1;
                enable_Y <= 0;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 1;
                enable_load <= 0;
            end
            
            4'hF: begin  // LOAD (Load switches into A)
                enable_A <= 1;
                enable_B <= 0;
                enable_Y <= 0;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 1;
            end
            
            default: begin
                // Reset all enable signals
                enable_A <= 0;
                enable_B <= 0;
                enable_Y <= 0;
                enable_add <= 0;
                enable_sub <= 0;
                enable_shl <= 0;
                enable_shr <= 0;
                enable_cmp <= 0;
                enable_and <= 0;
                enable_or <= 0;
                enable_xor <= 0;
                enable_nand <= 0;
                enable_nor <= 0;
                enable_xnor <= 0;
                enable_not <= 0;
                enable_neg <= 0;
                enable_sto <= 0;
                enable_swp <= 0;
                enable_load <= 0;
            end
        endcase
    end
    else begin
        // Reset all enable signals when button is not pressed
        enable_A <= 0;
        enable_B <= 0;
        enable_Y <= 0;
        enable_add <= 0;
        enable_sub <= 0;
        enable_shl <= 0;
        enable_shr <= 0;
        enable_cmp <= 0;
        enable_and <= 0;
        enable_or <= 0;
        enable_xor <= 0;
        enable_nand <= 0;
        enable_nor <= 0;
        enable_xnor <= 0;
        enable_not <= 0;
        enable_neg <= 0;
        enable_sto <= 0;
        enable_swp <= 0;
        enable_load <= 0;
    end
end

endmodule