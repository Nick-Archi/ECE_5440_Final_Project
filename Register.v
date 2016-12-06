//ECE 5440
//Author: Robert England 1232827	
module Register(Reg_Input, Reg_Output, Clk, Rst,Load,Load_out);
	input [3:0] Reg_Input;
	output [3:0] Reg_Output;
	reg [3:0] Reg_Output;
	input Clk, Rst, Load;
	output reg Load_out;
	always @(posedge Clk) begin
		if(Rst == 0)
			begin
				Reg_Output <= 4'b0000;
				Load_out<=0;
			end
		else if(Load == 1)
			begin
				Reg_Output <=Reg_Input;
				Load_out<=1;
			end
		else
			begin
				Load_out<=0;
			end
	end
endmodule