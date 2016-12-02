module Scorescoreer(PointReceived, valid, score, Clk, Rst);

	input PointReceived;
	input Clk, Rst, valid;
	output [4:0] score;

	reg [3:0] score;
	initial score <= 4'b0000;
	always @ (posedge Clk)
	begin
		if(Rst == 0)
		begin
			score <= 4'b0000;
		end
		else if(PointReceived == 1)
		begin
			if(valid == 1) begin
			score <= score + 1;
			end
		end
	end
endmodule 
