module TimerCountDown(clk, rst, enable, ms100, timeOut, stop);
	input clk, rst, enable, ms100;
	output reg [6:0] timeOut; 
	output reg stop;
	
	reg[4:0] count;
	parameter timeInSec=30; //time for game to run.
	
	parameter Wait=0, Start=1, Stop=2;
	reg[1:0] state;
	
	always@(posedge clk)begin
		
		if(rst==0)begin
			count<=0;
			state<=Wait;
			stop<=0;
			timeOut<=timeInSec;
		end
		else begin
			case(state)
				Wait: begin//waits for enable high
					if(enable==1) begin
						state<=Start;
						timeOut<=timeInSec;
					end
				end
				
				Start: begin
					if(ms100==1)begin
						count=count+1;
						if(count==10)begin
							timeOut<=timeOut-1;
							count=0;
						end
						
						if(timeOut==0)begin
							state<=Stop;
							stop<=1;
						end
					end	
				end
				
				Stop: begin
					stop<=0;
					if(enable==1) begin
						count<=0;
						timeOut<=timeInSec;
						state<=Start;
						stop<=0;
					end
				end
				
				default: begin
					count<=0;
					state<=Wait;
					stop<=0;
					timeOut<=timeInSec;
				end
			endcase
		end
		
	end
endmodule