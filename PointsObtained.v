module PointsObtained(b1, b2, b3, LED, Point, clk, rst);
	input b1, b2, b3, clk, rst;
	input [2:0] LED;
	
	output reg Point; //load to counter

	parameter s0 = 0, s1= 1, s2 = 2;
	
	reg state;
	
	always @(posedge clk) begin
		if(rst == 0) begin
			Point <= 0;
			state <= s0;
		end
		else begin
		case(state)
		
		s0: begin
				if(LED[0] == b1) begin
				Point <= 1;
				end
				state <= s1;
			end
		s1: begin
				if(LED[1] == b2) begin
				Point <= 1;
				end
				state <= s2;
			end
		s2: begin
				if(LED[2] == b3) begin
				Point <= 1;
				end
			end
		default: begin
				state <= s0;
				Point <= 0;
			end
		endcase
		end
	end
endmodule