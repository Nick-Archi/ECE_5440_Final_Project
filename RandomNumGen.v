module RandomNumGen(q,clk,reset);
	input clk,reset;
	output reg[1:0] q;
	reg[6:0] LFSR;
	reg time_out;
	
	always @(posedge clk)
	begin
		if(reset==0) begin
			LFSR<=7'b0000101;
		end
		else begin
			//if(enable==1) begin
				time_out<=0;
				LFSR[0] <= LFSR[2] ^ LFSR[4] ^ LFSR[6];
				LFSR[6:1] <= LFSR[5:0];
				if(LFSR[1:0]==2'b11) begin
					q<={1'b0,LFSR[0]};
				end
				else begin
					q<=LFSR[1:0];
				end
				if(LFSR==8) begin
					time_out<=1;
				end
				if(time_out) begin
					LFSR<=7'b0000101;
					time_out<=0;
				end
			//end
		end
	end

  //assign q = LFSR;
endmodule
