//ECE 5440
//Author: Robert England 1232827	
module ButtonShaper(B_In, B_Out, Rst, Clk);
	input B_In, Rst, Clk;
	output reg B_Out;
	parameter S_Off = 0, S_Pulse = 1, S_Wait = 2;
	reg [1:0] State, StateNext;
	always @(State, B_In) begin
		case(State)
			S_Off: begin
				B_Out<=0;
				if(B_In == 1)
					begin
						StateNext <= S_Off;
					end
				else
					begin
						StateNext <= S_Pulse;
					end
			end
			S_Pulse: begin
				B_Out<=1;
				StateNext <= S_Wait;
			end
			S_Wait: begin
				B_Out<=0;
				if(B_In == 0)
					begin
						StateNext <= S_Wait;
					end	
				else
					StateNext <= S_Off;
			end
			default: begin
				B_Out<=0;
				StateNext <= S_Off;
			end
		endcase
	end
	always @(posedge Clk) begin
		if(Rst == 0)
			begin
				State <= S_Off;
			end
		else	
			State <= StateNext;
		end
endmodule
				