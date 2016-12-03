/* 	Module: UserSelect
*
* 	Description: Controls the TimerSpeed and UserLogin modules through the selection of a toggle switch 
*	on the board that is checked during reset. If the user wants to continue as a guest 
*	then the switch should be pulled down, if not then it is assumed that 
*	the user has a known password and will be prompted for this. 
*
*	Created By: Nicholas
*
*/

module UserSelect(toggle, flag, clk, rst);

	/* inputs
	*	toggle = switch that determines if the user is a guest or not
	*/
	input toggle, clk, rst;
	
	/* outputs/reg
	*	flag = notifies the other modules of the decision made by the user
	* 	flag == 1 if the user wants to enter a password
	*/
	output reg flag;

	/* reg
	*	
	*/
	reg[1:0] state;
	
	/* parameter
	*	
	*/	
	parameter sWait = 0, s1 = 1, s2 = 2;
	
	always@(posedge clk) begin
		
		if(rst == 0) begin
		
			if(toggle == 1) begin
				flag <= 1;	
			end // end of toggle if
			
			else begin
				flag <= 0;
			end
			
		end // end of rst if
		
		/*
		*	FSM used to continue outputting the decision by the user... not sure if necessary or not
		*/
		else begin
			case(state)
				
				sWait: begin
					flag <= flag;
					state <= sWait;
				end
				
				default: begin
					flag <= flag;
					state <= sWait;
				end
					
			endcase
		end // enter a do nothing stage
		
	end
	
	
endmodule 