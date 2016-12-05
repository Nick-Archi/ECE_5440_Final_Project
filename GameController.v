module GameController(GO, timeOut, done, seq, LED, clk, rst);

input timeOut, enable, clk, rst;
input [2:0] seq;
input GO;

output reg [2:0] LED;


always @(posedge clk) begin
	if(rst == 0) begin
		LED <= 3'b000;
	end
	else begin 
	end
end
endmodule