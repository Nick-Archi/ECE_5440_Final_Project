module ScoreDisp(score,scoredisp);
	input [3:0] score;
	output [6:0] scoredisp;
	reg [6:0] scoredisp;

	always @(score) begin
		case(score) 
			4'b0000: begin
			scoredisp=7'b1000000; 
			end
			4'b0001: begin
			scoredisp=7'b1111001; 
			end
			4'b0010: begin
			scoredisp=7'b0100100; 
			end
			4'b0011: begin
			scoredisp=7'b0110000;
			end
			4'b0100: begin
			scoredisp=7'b0011001;
			end
			4'b0101: begin
			scoredisp=7'b0010010;
			end
			4'b0110: begin
			scoredisp=7'b0000010;
			end
			4'b0111: begin
			scoredisp=7'b1111000;
			end
			4'b1000: begin
			scoredisp=7'b0000000;
			end
			4'b1001: begin
			scoredisp=7'b0011000; 
			end
			default: begin
			scoredisp=7'b1111111;
			end
		endcase
	end
endmodule