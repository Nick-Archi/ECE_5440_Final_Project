module LED_Score(change, start, bIN1, bIN2, bIN3, randNum, clk, rst, led1, led2, led3, score);
	input change, start, bIN1, bIN2, bIN3, clk, rst;
	input [1:0] randNum; //there will be three LED's, therefore we only need 2 bits from the randomLFSR
	output reg led1, led2, led3;
	output reg [3:0] score;
	
	parameter s0 = 0, s1 = 1, s2 =2;
	
	always @(posedge clk) begin
	
		if(rst == 0) begin
			score <= 4'b0000;
			led1 <= 0; led2 <= 0; led3 <= 0;
		end
		else begin
			if(start == 1) begin
				if(change == 1) begin
					case(randNum)
						s0: begin
							led1 <= 1; led2 <= 0; led3 <= 0; //assuming GPIO Pins are active high
						end	
						s1: begin
							led1 <= 0; led2 <= 1; led3 <= 0;
						end
				
						s2: begin
							led1 <= 0; led2 <= 0; led3 <= 1;
						end
						default: begin
							led1 <= 0; led2 <= 0; led3 <= 0;	
						end
					endcase
				end	
				
				if(bIN1 == 1 && led1 == 1) begin
					led1 <= 0;
					score <= score + 1;
				end
				if(bIN2 == 1 && led2 == 1) begin
					led2 <= 0;
					score <= score + 1;
				end
				if(bIN3 == 1 && led3 == 1) begin
					led3 <= 0;
					score <= score + 1;
				end
				
			end	
		end
	end
endmodule