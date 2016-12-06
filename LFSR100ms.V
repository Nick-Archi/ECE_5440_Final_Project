module LFSR100ms(rst, clk,enable, ms100);
  input rst, clk,enable;
  //output reg[12:0] q;
  output reg ms100;
  
  reg [12:0] LFSR;
  wire feedback = LFSR[12];
  
  reg[12:0] COUNT;
  always @(posedge clk)
  begin
	if(rst==0)begin
		//q<=0;
		LFSR<=1;
		ms100<=0;		
	end
	else if(enable==1)begin
		LFSR[0] <= feedback;
		LFSR[1] <= LFSR[0] ^ feedback;
		LFSR[2] <= LFSR[1];
		LFSR[3] <= LFSR[2] ^ feedback;
		LFSR[4] <= LFSR[3] ^ feedback;
		LFSR[5] <= LFSR[4];
		LFSR[6] <= LFSR[5];
		LFSR[7] <= LFSR[6];
		LFSR[8] <= LFSR[7];
		LFSR[9] <= LFSR[8];
		LFSR[10] <= LFSR[9];
		LFSR[11] <= LFSR[10];
		LFSR[12] <= LFSR[11];
		COUNT<=COUNT+1;
		
		if(LFSR==908)begin //5000 number
			//q<=LFSR;
			ms100<=1;
			LFSR<=1;
		end
		else begin 
			ms100<=0;
		end
		
		//else if(LFSR==1816)begin //5001 number
			//q<=0;
			//LFSR<=2; //2nd number in lfsr sequence 
			//ms100<=0;	
		//end
	end
  
  
    
  end

endmodule
