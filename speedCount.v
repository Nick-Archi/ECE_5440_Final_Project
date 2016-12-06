module speedCount(rst, clk,enable,speed,ms100,timeout);
	input rst, clk,enable,ms100;
	input[1:0] speed;
	output reg timeout;
	
	reg[3:0] count;
	
	parameter speed1 = 0,speed2 = 1,speed3 = 2;
	reg[3:0] countset;
	
	always@(posedge clk)begin
		
		if(rst==0)begin
			count<=0;
		end
		else if(enable==1)begin
			case(speed)
				speed1:
					countset<=10; //1 sec
				speed2:
					countset<=8; //.8 sec
				speed3:
					countset<=6; //.6 sec
				default:
					countset<=10; //1 sec
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
endmodule
	