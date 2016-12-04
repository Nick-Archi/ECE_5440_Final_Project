module RandomNum(Enable, Reset, Clock, Q, Time_Out);
	input Enable, Reset, Clock; 
	output [3:0] Q;
	output Time_Out;

	reg Time_Out;
	reg [3:0] LFSR;
  reg [3:0] State;
  parameter Normal = 0, Intermediate = 1, Advanced = 2;
	wire Feedback = LFSR[3];

	always @(posedge Clock) begin
		if (Reset == 0) begin
			LFSR <= 4'b1111; 
		end
		else begin
      case (State) 
          Beginner: begin
              if (Enable == 1) begin
				          Time_Out <= 0; // There is no Time_Out when generator is working. 
				          LFSR[0] <= feedback;
                  LFSR[1] <= LFSR[0] ^ feedback;
                  LFSR[2] <= LFSR[1] ^ feedback;
                  LFSR[3] <= LFSR[2] ^ feedback;
			        end
			        else begin
				          Time_Out <= 1; // There is a Time_Out when Enable is 0. 
			        end
          end
          Intermediate: begin
              if (Enable == 1) begin
				          Time_Out <= 0; // There is no Time_Out when generator is working. 
				          LFSR[0] <= feedback;
                  LFSR[1] <= LFSR[0] ^ feedback;
                  LFSR[2] <= LFSR[1] ^ feedback;
                  LFSR[3] <= LFSR[2];
			        end
			        else begin
				          Time_Out <= 1; // There is a Time_Out when Enable is 0. 
			        end
          end
          Advanced: begin
			        if (Enable == 1) begin
				          Time_Out <= 0; // There is no Time_Out when generator is working. 
				          LFSR[0] <= Feedback; // LFSR Generator generating 4-bit numbers based on XOR Gate. 
				          LFSR[1] <= LFSR[0] ^ Feedback;
				          LFSR[2] <= LFSR[1];
				          LFSR[3] <= LFSR[2];
			        end
			        else begin
				          Time_Out <= 1; // There is a Time_Out when Enable is 0. 
			        end
		     end
         default: begin
              if (Enable == 1) begin
				          Time_Out <= 0; // There is no Time_Out when generator is working. 
				          LFSR[0] <= feedback;
                  LFSR[1] <= LFSR[0] ^ feedback;
                  LFSR[2] <= LFSR[1] ^ feedback;
                  LFSR[3] <= LFSR[2] ^ feedback;
			        end
			        else begin
				          Time_Out <= 1; // There is a Time_Out when Enable is 0. 
			        end
          end
      endcase
	  end
  end
	assign Q = LFSR; // Assign LFSR 4-Bit Number to Output Q. 
endmodule
