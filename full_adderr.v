module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    input wire clk,     // Dummy clock required by OpenLane
    input wire vdd,     // Power net
    input wire gnd,     // Ground net
    output wire sum,
    output wire cout
);

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
