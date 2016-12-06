//ECE 5440
//Author: Robert England 1232827
module SegDisplay(Decryted_input,Display_output);
input [3:0] Decryted_input;
	output [6:0] Display_output;
	reg [6:0] Display_output;
	
	always @(Decryted_input)
		begin
			case(Decryted_input)
				4'b0000:	begin	// input 0
								//Display_output=7'b0111111;
								Display_output=7'b1000000;
							end
				4'b0001:	begin	// input 1
								//Display_output=7'b0000110;
								Display_output=7'b1111001;
							end
				4'b0010:	begin	// input 2
								//Display_output=7'b1011011;
								Display_output=7'b0100100;
							end
				4'b0011:	begin	// input 3
								//Display_output=7'b1001111;
								Display_output=7'b0110000;
							end
				4'b0100:	begin	// input 4
								//Display_output=7'b1100110;
								Display_output=7'b0011001;
							end
				4'b0101:	begin	// input 5
								//Display_output=7'b1101101;
								Display_output=7'b0010010;
							end
				4'b0110:	begin	// input 6
								//Display_output=7'b1111101;
								Display_output=7'b0000010;
							end
				4'b0111:	begin	// input 7
								//Display_output=7'b0000111;
								Display_output=7'b1111000;
							end
				4'b1000:	begin	// input 8
								//Display_output=7'b1111111;
								Display_output=7'b0000000;
							end
				4'b1001:	begin	// input 9
								//Display_output=7'b1101111;
								Display_output=7'b0010000;
							end
				default:	begin
								//Display_output=7'b1110001;
								Display_output=7'b0001110;
							end
			endcase
		end
endmodule