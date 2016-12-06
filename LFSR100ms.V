module LFSR100ms(rst, clk,enable, ms100);
  input rst, clk,enable;

  output reg ms100;
  
  reg [12:0] LFSR;
  wire feedback = LFSR[12];
  
  parameter Wait=0, Start=1, Stop=2;
  reg[1:0] state;
  
  always @(posedge clk)
  begin
	if(rst==0)begin
		LFSR<=1;
		ms100<=0;
		state<=Wait;
	end
	else begin
		case(state)
			Wait: begin
				if(enable==1) begin
					state<=Start;
				end
			end
			
			Start: begin
				if(enable!=1)begin//waits for enable high
					state<=Stop;
					ms100<=0;
				end
				else begin
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
					
					if(LFSR==908)begin //5000 number
						ms100<=1;
						LFSR<=1; //resets LFSR
					end
					else begin 
						ms100<=0;
					end
				end
			end
			
			Stop: begin
				if(enable==1) begin 
					LFSR<=1;
					ms100<=0;
					state<=Start;
				end
			end
			
			default: begin
				LFSR<=1;
				ms100<=0;
				state<=Wait;
			end
		endcase
	end
  
  
    
  end

endmodule
