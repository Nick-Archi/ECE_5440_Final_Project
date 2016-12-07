//ECE 5440
//Author: Robert England 1232827
module SegDisplay(seg_input,display);
input [3:0] seg_input;
	output [6:0] display;
	reg [6:0] display;
	
	always @(seg_input)
		begin
			case(seg_input)
				4'b0000:	begin	// input 0
								//display=7'b0111111;
								display=7'b1000000;
							end
				4'b0001:	begin	// input 1
								//display=7'b0000110;
								display=7'b1111001;
							end
				4'b0010:	begin	// input 2
								//display=7'b1011011;
								display=7'b0100100;
							end
				4'b0011:	begin	// input 3
								//display=7'b1001111;
								display=7'b0110000;
							end
				4'b0100:	begin	// input 4
								//display=7'b1100110;
								display=7'b0011001;
							end
				4'b0101:	begin	// input 5
								//display=7'b1101101;
								display=7'b0010010;
							end
				4'b0110:	begin	// input 6
								//display=7'b1111101;
								display=7'b0000010;
							end
				4'b0111:	begin	// input 7
								//display=7'b0000111;
								display=7'b1111000;
							end
				4'b1000:	begin	// input 8
								//display=7'b1111111;
								display=7'b0000000;
							end
				4'b1001:	begin	// input 9
								//display=7'b1101111;
								display=7'b0010000;
							end
				default:	begin
								//display=7'b1110001;
								display=7'b0001110;
							end
			endcase
		end
endmodule