module subtract (
    input [7:0] A, B,
    output [7:0] Y
);

    wire [7:0] A_twos;
    wire [7:0] B_twos;
    wire carry1, carry2, carry3, carry4, carry5, carry6, carry7;

    assign A_twos = A;

    twos_compliment Btwos(
        .A(B),
        .Y(B_twos)
    );

    full_adder add0(
        .A(A_twos[0]),
        .B(B_twos[0]),
        .Cin(1'b0),
        .Y(Y[0]),
        .Cout(carry1)
    );

    full_adder add1(
        .A(A_twos[1]),
        .B(B_twos[1]),
        .Cin(carry1),
        .Y(Y[1]),
        .Cout(carry2)
    );
    full_adder add2(
        .A(A_twos[2]),
        .B(B_twos[2]),
        .Cin(carry2),
        .Y(Y[2]),
        .Cout(carry3)
    );
    full_adder add3(
        .A(A_twos[3]),
        .B(B_twos[3]),
        .Cin(carry3),
        .Y(Y[3]),
        .Cout(carry4)
    );
    full_adder add4(
        .A(A_twos[4]),
        .B(B_twos[4]),
        .Cin(carry4),
        .Y(Y[4]),
        .Cout(carry5)
    );
    full_adder add5(
        .A(A_twos[5]),
        .B(B_twos[5]),
        .Cin(carry5),
        .Y(Y[5]),
        .Cout(carry6)
    );
    full_adder add6(
        .A(A_twos[6]),
        .B(B_twos[6]),
        .Cin(carry6),
        .Y(Y[6]),
        .Cout(carry7)
    );
    full_adder add7(
        .A(A_twos[7]),
        .B(B_twos[7]),
        .Cin(carry7),
        .Y(Y[7])
    );
 
endmodule