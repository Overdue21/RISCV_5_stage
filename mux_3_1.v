module mux_3_1
#(
    parameter   WIDTH = 32
)
(
    input [WIDTH-1:0] in1,
    input [WIDTH-1:0] in2,
    input [WIDTH-1:0] in3,
    input [1:0] select,
    output reg [WIDTH-1:0] out
);

always @( * ) begin
    case (select) 
        2'd0: out = in1;
        2'd1: out = in2;
        2'd2: out = in3;
        default: out = {WIDTH{1'b0}};
    endcase
end

endmodule