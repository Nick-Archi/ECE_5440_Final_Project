/* 	Module: Pause
*
* 	Description: Module is a "pause" that is incorporated to allow the user to make
*	a selection on whether they want to enter a password or continue as a guest, so this allows
*	a selection on the level before it is seen by the UserSelect module.
*
*	Created By: Nicholas
*
*/

module Pause(switchIn, toggle, clk, rst);

	/* inputs
	*	switchIn = toggle switch input 
	*/
	input switchIn, clk, rst;
	
	
	/* outputs/reg
	*	toggle = flag that is set to 1 to indicate that the pause stage is done and that the
	*	selection should have been made.
	*/
	output reg toggle;
	
	/* reg
	*	
	*/
	reg[1:0] state;

	/* parameter
	*	
	*/	
	parameter sWait = 0, s1 = 1, sDone = 2;

	always@(posedge clk) begin
	
		if(rst == 0) begin
			state <= sWait;
			toggle <= 0; 
		end // end of if
		
		else begin
			case(state)
				
				sWait: begin
					if(switchIn == 0) begin // meaning that the toggle switch is still high
						state <= sWait; // stay in the wait stage
					end // end of if
					
					else begin
						state <= s1;
					end
				end
				
				s1: begin
					if(switchIn == 1) begin
						state <= s1;
					end
					
					else begin
						state <= sDone;
					end
				end
				
				// selection has been made permenant by the user
				sDone: begin
					toggle <= 1; 
					state <= sDone;
				end
				
				default: begin
					toggle <= 0;
					state <= sWait;
				end
				
				
			endcase
		end // end of else
	
	end // end always@
	
	

endmodule