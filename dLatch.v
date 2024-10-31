module dLatch (
    input [7:0]D, E,       
    output reg [7:0]Q,      
    output [7:0]Qn          
);
    assign Qn = ~Q;    

    always @(D, E) begin
        if (E)         
            Q <= D;   
    end
endmodule