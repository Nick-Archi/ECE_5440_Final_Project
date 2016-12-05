/* 	Module: UserSelect
*
* 	Description: Controls the TimerSpeed and UserLogin modules through the selection of a toggle switch 
*	on the board that is checked during reset and after the pause stage. If the user wants to continue as a guest 
*	then the switch should've been pulled down during the pause stage, if not then it is assumed that 
*	the user has a known password and will be prompted for this. 
*
*	Created By: Nicholas
*
*/

module UserSelect(toggle, pause, ready, clk, rst);

	/* inputs
	*	toggle = switch that determines if the user is a guest or not
	*/
	input toggle, pause, clk, rst;
	
	/* outputs/reg
	*	ready = notifies the other modules of the decision made by the user
	* 	ready == 1 if the user wants to enter a password
	*/
	output reg ready;

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
		
			ready <= 0;
			state <= sWait;
			
		end // end of rst if
		
		/*
		*	
		*/
		else begin
			case(state)
				
				sWait: begin
					if(pause == 0) begin // selection has not been made by user yet
						state <= sWait;
					end
					
					else begin
						state <= s1;
					end
				end // end sWait
				
				s1: begin
					if(toggle == 0) begin // user is a guest
						ready <= 0;
					end
					
					else begin
						ready <= 1;
					end
					
					state <= sDone;
				end
				
				sDone: begin
					//ready <= ready;
				end
				
				default: begin
					ready <= 0;
					state <= sWait;
				end
					
			endcase
		end // enter a do nothing stage
		
	end
	
	
endmodule 