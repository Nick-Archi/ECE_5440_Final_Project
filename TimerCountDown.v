module TimerCountDown(clk, rst, enable, ms100, timeOut, stop);
	input clk, rst, enable, ms100;
	output reg [6:0] timeOut; 
	output reg stop;
	
	reg[6:0] count;
	parameter timeInSec=60; //time for game to run.
	
	parameter Wait=0, Start=1, Stop=2;
	reg[1:0] state;
	
	always@(posedge clk)begin
		
		if(rst==0)begin
			count<=timeInSec*10;
			state<=Wait;
			stop<=0;
			timeOut<=0;
		end
		else begin
			case(state)
				Wait: begin//waits for enable high
					if(enable==1) begin
						state<=Start;
						timeOut<=count;
					end
				end
				
				Start: begin
					if(enable!=1) begin //if enable goes low, game stops
						state<=stop;
						stop<=1;
					end
					else begin
						if(ms100==1)begin
							count=count-1;
							timeOut<=count;
							if(count==0)begin
								state<=Stop;
							end
						end
					end	
				end
				
				Stop: begin
					if(enable==1) begin
						count<=timeInSec*10;
						timeOut<=count;
						state<=Start;
						stop<=0;
					end
				end
				
				default: begin
					count<=timeInSec*10;
					state<=Wait;
					stop<=0;
					timeOut<=0;
				end
			endcase
		end
		
	end
endmodule