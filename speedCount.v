module speedCount(rst, clk,enable,speed,ms100,timeout);
	input rst, clk,enable,ms100;
	input[1:0] speed;
	output reg timeout;
	
	reg[6:0] count;
	
	parameter speed1 = 0,speed2 = 1,speed3 = 2;
	reg[6:0] countset;
	
	parameter Wait=0, Start=1, Stop=2;
	reg[1:0] state;
	
	always@(posedge clk)begin
		
		if(rst==0)begin
			count<=0;
			state<=Wait;
		end
		else begin
			case(state)
				Wait: begin//waits for enable high
					if(enable==1) begin
						state<=Start;
					end
				end
				
				Start: begin
					if(enable!=1) begin
						state<=Stop;
					end	
					else begin
						case(speed)
							speed1:
								countset<=10; //1.5 sec
							speed2:
								countset<=7; //1 sec
							speed3:
								countset<=4; //.5 sec
							default:
								countset<=15; //1.5 sec
						endcase
						
						if(ms100==1)begin//checks for ms100 signal
							count<=count+1;
							if(count==countset)begin//once count is equal to countset, timeout is high and count is reset to 0
								timeout<=1;
								count<=0;
							end
						end
						else begin
								timeout<=0;
							end
								end
				end
				
				Stop: begin
					if(enable==1) begin
						count<=0;
						state<=Start;
					end
				end
				
				default: begin
					count<=0;
					state<=Wait;
				end
			endcase
		end
	end
endmodule
	