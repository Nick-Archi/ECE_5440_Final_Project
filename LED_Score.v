module LED_Score(change, start, bIn1, bIn2, bIn3, randNum, clk, rst, led1, led2, led3, score);
	input change, start, bIn1, bIn2, bIn3, clk, rst;
	input [1:0] randNum; //there will be three LED's, therefore we only need 2 bits from the randomLFSR
	output reg led1, led2, led3;
	output reg [6:0] score;
	
	parameter s0 = 0, s1 = 1, s2 =2;
	
	parameter Wait=0, Start=1, Stop=2;
	reg[1:0] state;
	
	always @(posedge clk) begin
	
		if(rst == 0) begin
			score <= 6'b000000;
			led1 <= 0; led2 <= 0; led3 <= 0;
			state<=Wait;
		end
		else begin
			case(state)
				Wait: begin
					if(start==1) begin
						state<=Start;
					end
				end
				
				Start: begin
					if(start!=1) begin
						state<=Stop;
					end
					else begin
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
						
						if(bIn1 == 1 && led1 == 1) begin
							led1 <= 0;
							score <= score + 1;
						end
						if(bIn2 == 1 && led2 == 1) begin
							led2 <= 0;
							score <= score + 1;
						end
						if(bIn3 == 1 && led3 == 1) begin
							led3 <= 0;
							score <= score + 1;
						end
					end
				end
				Stop: begin
					led1 <= 0; led2 <= 0; led3 <= 0;
					if(start==1)begin
						score <= 0;
						led1 <= 0; led2 <= 0; led3 <= 0;
						state<=Start;
					end
				end	
				
				default begin
					score <= 6'b000000;
					led1 <= 0; led2 <= 0; led3 <= 0;
					state<=Wait;
				end
			endcase	
		end
	end
endmodule