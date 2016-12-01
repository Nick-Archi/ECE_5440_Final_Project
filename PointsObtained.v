module PointsObtained(b1, b2, b3, LED, PFout, clk, rst);
	input b1, b2, b3, clk, rst;
	input [2:0] LED;
	
	output reg PFout; //load to counter

	parameter s0 = 0, s1= 1, s2 = 2;
	
	reg state;
	
	always @(posedge clk) begin
		if(rst == 0) begin
			PFout <= 0;
			state <= s0;
		end
		else begin
		case(state)
		
		s0: begin
				if(LED[0] == b1) begin
				PFout <= 1;
				end
				state <= s1;
			end
		s1: begin
				if(LED[1] == b2) begin
				PFout <= 1;
				end
				state <= s2;
			end
		s2: begin
				if(LED[2] == b3) begin
				PFout <= 1;
				end
			end
		endcase
		end
	end
endmodule