module mux_2_1
#(
    parameter   WIDTH = 32
)
(
    input [WIDTH-1:0] in1,
    input [WIDTH-1:0] in2,
    input select,
    output reg [WIDTH-1:0] out
);

always @( * ) begin
    case (select) 
        1'd0: out = in1;
        1'd1: out = in2;
        default: out = {WIDTH{1'b0}};
    endcase
end

endmodule