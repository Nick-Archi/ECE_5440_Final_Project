/* 	Module: TimerSpeed
*
* 	Description: Manipulates the speed of the game from each level by 
*	using two toggle switches from the board. 
*	Then in the board we switched them based on their binary bits which are 
*	00 = Normal, 01 = Intermediate 10 = Advanced. 
*	The description of each level is shown above under “interfaces.” 
*
*	Created By: Jose 
*	Last Edited: Nicholas 
*
*/

/*
*
*/
module TimerSpeed(level, ready, gameSpeed, control, clk, rst);

	/* inputs
	*	level = selection from the toggle switches
	*	ready = selection from a toggle switch to indicate user is fine with their options
	*/
	input[1:0] level; 
	input clk, rst;
	input ready;
	
	/* outputs/reg
	*	gameSpeed = selects the gameSpeed for the timer
	*	control = is turned to a 1 to indicate to the timer that the selection is ready 
	*		no selections will be seen by RandomNum till control is 1
	*/
	output reg[1:0] gameSpeed; 
	output reg control;
	
	/* reg
	*	
	*/	
	reg state;
	
	/* parameter
	*
	*/
	parameter normal = 2'b00, intermediate = 2'b01, advanced = 2'b10;
	parameter sWait = 0, s1 = 1, s2 = 2; 
	
	always@(posedge clk) begin 
		if(rst == 0) begin			
			gameSpeed <= 2'b00; 	
			control <= 1'b0;
			state <= sWait;
		end
		
		else begin
			case(state) 
			
				sWait: begin	// ready switch is still a 0
					control <= 1'b0;
					if(ready == 1'b0) begin
						state <= sWait;
					end
					
					else begin
						state <= s1;
					end
				end
				
				s1: begin	// ready switched to 1
					// begin selection for gameSpeed based on the level selected
					control <= 1'b0;

					case(level) 
					
						normal: begin
							gameSpeed <= normal;
						end
						
						intermediate: begin
							gameSpeed <= intermediate;

						end
						
						advanced: begin
							gameSpeed <= advanced;
						end
					
					endcase
					
					if(ready == 1'b0) begin // if the switch is changed to a 0 go to nxt state
						state <= s2;
					end
					
					else begin // if switch is still a 1 then stay...
						state <= s1;
					end
					
				end
				
				/*
				*	It should stay in this state for as long as the reset is toggled meaning that
				*	it's time to make a new selection.
				*/
				s2: begin	// ready is switched to 0 and the user is ready
					control <= 1'b1; // selection is ready
					
					state <= s2;	// stay in this state until reset is pushed
					
				end
				
				default: begin
					gameSpeed <= 2'b00;
					state <= sWait;
				end
				
			endcase
		
		end // end for else
		
	end // end of always@

endmodule    
