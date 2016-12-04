module RandomNum(GameSpeed, Clock, Reset, Q, Enable);
	input [1:0] GameSpeed;
	input Clock, Reset; 
	output [3:0] Q;
	output Enable;

	reg Enable;
	reg [3:0] LFSR;
	reg [3:0] State;
	parameter Normal = 0, Intermediate = 1, Advanced = 2;
	wire Feedback = LFSR[3];

	always @(posedge Clock) begin
		if (Reset == 0) begin
			LFSR <= 4'b1111; 
			Enable <= 0;
		end
		else begin
			case (State) 
				Normal: begin
					if (GameSpeed == 2'b00) begin
				        Enable <= 1;
				        LFSR[0] <= Feedback;
						LFSR[1] <= LFSR[0] ^ Feedback;
						LFSR[2] <= LFSR[1] ^ Feedback;
						LFSR[3] <= LFSR[2] ^ Feedback;
			        end
			        else begin
				        Enable <= 0; 
						State <= Intermediate;
			        end
				end
				Intermediate: begin
					if (GameSpeed == 2'b01) begin
				        Enable <= 1; 
				        LFSR[0] <= Feedback;
						LFSR[1] <= LFSR[0] ^ Feedback;
						LFSR[2] <= LFSR[1] ^ Feedback;
						LFSR[3] <= LFSR[2];
			        end
			        else begin
				        Enable <= 0; 
						State <= Advanced;
			        end
				end
				Advanced: begin
			        if (GameSpeed == 2'b10) begin
						Enable <= 1; 
				        LFSR[0] <= Feedback;  
				        LFSR[1] <= LFSR[0] ^ Feedback;
				        LFSR[2] <= LFSR[1];
				        LFSR[3] <= LFSR[2];
			        end
			        else begin
				        Enable <= 0;
						State <= Normal;
			        end
				end
				default: begin
					Enable <= 0;
					State <= Normal;
				end
			endcase
		end
	end
	assign Q = LFSR;  
endmodule
