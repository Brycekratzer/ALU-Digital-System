module opermux(
    input [7:0] data_in,     // Signed 8-bit input data for loading or storing in A
    input [3:0] selector,           // 4-bit selector for ALU operation
    input reset,  
    input enable,                  // Reset signal to zero all registers
    output reg [7:0] Y,      // Signed 8-bit output for result
    output reg [7:0] ALed,   // Signed 8-bit LED output for register A
    output reg [7:0] BLed    // Signed 8-bit LED output for register B
);

    // Internal signed 8-bit registers
    reg [7:0] A;
    reg [7:0] B;
    reg [7:0] tmp;

    wire reg [7:0] A_twoscomp;
    wire reg [7:0] A_sub;
    wire reg [7:0] A_add;

    twos_compliment Atwo(
        .A(A[7:0]),
        .Y(A_twoscomp[7:0])
    );

    adder add(
        .A(A[7:0]),
        .Y(A_add[7:0])
    );

    subtract sub(
        .A(A[7:0]),
        .Y(A_sub[7:0])
    );

    // Reset all registers to zero
    always @(posedge reset) begin
        A <= 8'sd0;
        B <= 8'sd0;
        Y <= 8'sd0;
    end

    // ALU operation based on selector
    always @(enable) begin
        case(selector)
            4'b0000: Y = A_add// Add          
            4'b0001: Y = A_sub// Sub                          
            4'b0010: Y = A <<< 1;      
            4'b0011: Y = A >>> 1;         
            4'b0100: begin              
                if (A == B) 
                    Y = 8'sd0;            
                else if (A > B) 
                    Y = 8'sd1;           
                else 
                    Y = -8'sd1;           
            end
            4'b0101: Y = A & B;           
            4'b0110: Y = A | B;          
            4'b0111: Y = A ^ B;           
            4'b1000: Y = ~(A & B);        
            4'b1001: Y = ~(A | B);       
            4'b1010: Y = ~(A ^ B);        
            4'b1011: Y = ~A;             
            4'b1100: Y = A_twos;// Two's Complement (Negate A)
            4'b1101: A = Y;               
            4'b1110: begin                
                tmp = A;
                A = B;
                B = tmp;
            end
            4'b1111: begin
                temp = A;
                A = data_in; 
                B = temp;
            end
        endcase
        ALed = A;
        BLed = B;
    end
endmodule