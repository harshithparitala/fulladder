module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    input wire clk,
    input wire vdd,
    input wire gnd,
    output wire sum,
    output wire cout
);

    // drive internal signals from power/ground to ensure connectivity
    wire pwr = vdd;
    wire gnd_ref = gnd;

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
