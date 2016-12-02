module ScoreCounter(PointRecieved, COUNT, Clk, Rst);

	input PointRecieved;
	input Clk, Rst;
	output [4:0] COUNT;

	reg [3:0] COUNT;
	initial COUNT <= 4'b0000;
	always @ (posedge Clk)
	begin
		if(Rst == 0)
		begin
			COUNT <= 4'b0000;
		end
		else if(PointRecieved == 1)
		begin
			COUNT <= COUNT + 1;
		end
	end
endmodule 