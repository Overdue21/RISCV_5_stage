module FETCH_PC
(
    input [31:0] address,
    //Active low
    input enable,
    input reset,
    input clk,
    output reg [31:0] out
);

always @( * ) begin
    if (reset) begin
        out <= 32'b0;
    end
end

always @(posedge clk) begin
    if (!enable) begin
        out <= address;
    end
end

endmodule