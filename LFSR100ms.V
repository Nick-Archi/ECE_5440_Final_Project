module LFSR100ms(rst, clk,enable, ms100);
  input rst, clk,enable;
  output reg ms100;
  
  reg [15:0] LFSR;
  wire feedback = LFSR[15];
  
  reg[7:0] COUNT;
  always @(posedge clk)
  begin
	if(rst==0)begin
		LFSR<=1;
		ms100<=0;
		COUNT<=0;
	end
	else if(enable==1)begin
		LFSR[0] <= feedback;
		LFSR[1] <= LFSR[0];
		LFSR[2] <= LFSR[1] ^ feedback;
		LFSR[3] <= LFSR[2] ^ feedback;
		LFSR[4] <= LFSR[3];
		LFSR[5] <= LFSR[4] ^ feedback;
		LFSR[6] <= LFSR[5];
		LFSR[7] <= LFSR[6];
		LFSR[8] <= LFSR[7];
		LFSR[9] <= LFSR[8];
		LFSR[10] <= LFSR[9];
		LFSR[11] <= LFSR[10];
		LFSR[12] <= LFSR[11];
		LFSR[13] <= LFSR[12];
		LFSR[14] <= LFSR[13];
		LFSR[15] <= LFSR[14];
		
		if(LFSR==16'hb11f)begin //50,000 number
			COUNT<=COUNT+1;
			if(COUNT==100)begin
				COUNT<=0;
				ms100<=1;
				LFSR<=1;
			end
			else begin 
				ms100<=0;
			end
		end
		else begin 
			ms100<=0;
		end
	end
	else begin
		LFSR<=1;
		ms100<=0;
		COUNT<=0;
	end
  end
endmodule
