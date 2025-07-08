module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    input wire clk,
    output wire sum,
    output wire cout
);

    // Internal power/ground nets
    supply1 vdd;
    supply0 gnd;

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
