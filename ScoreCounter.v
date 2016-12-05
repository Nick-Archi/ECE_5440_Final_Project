module ScoreCounter(PointReceived, valid, score, Clk, Rst);

	input PointRecieved;
	input Clk, Rst, valid;
	output [3:0] score;

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
