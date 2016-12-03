/* 	Module: CheckMemory
*
* 	Description: Takes the user’s ID and checks the memory in order to access the user’s specified level 
* 	(if not a guest) and high score (RAM/ROM). The end of our memory will be signified with a 
*	‘FFFF’, if the address hits this and there has been no match with the user’s password, 
*	then a flag is set to indicate this
*
*	Created By: Nicholas
*
*/

module CheckMemory(password, displayLevel, notify, flag, clk, rst);

	/* inputs
	*	password = 16 bit number from the UserLogin module
	*	notify = set to a 1 to indicate the checking process to begin, from the UserLogin module
	*/
	input[15:0] password;
	input clk, rst;
	input notify;
	
	/* outputs/reg
	*	flag = set to 1 if the user's password is recgonized
	*	displayLevel = used to display level on Seven Segment Display
	*/
	output reg flag;
	output reg[7:0] displayLevel;

	/* reg
	*	
	*/
	reg[1:0] state;
	
	/* parameter
	*	stop = stops the incrementating of the address signaling the end of memory, which would be
	*	FFFF
	*/	
	parameter sWait = 0, s1 = 1, s2 = 2, sDone = 3;
	parameter[15:0] stop = 16'hffff; 
		
	/* reg
	*	address = 8 bit address in the ROM
	*/
	reg[7:0] address;
	
	/* wire
	*	check = 4 bit password in the ROM memory
	*/
	wire[15:0] check;
	
	/* other module
	*	
	*/
	myROM ROM(address, clk, check);
	
	
	always@(posedge clk) begin
		
		if(rst == 0) begin
			flag <= 0;
			state <= sWait;
			displayLevel <= 7'b0000110;
			address <= 7'b0000000;			
		end
		
		/*
		*	Creation of the memory controller portion that will move through the address in 
		*	the ROM and verify if the user's password is in one of them
		*/
		else begin
			case(state) 

			sWait: begin
				if(notify == 0) begin
					state <= sWait; // do not begin process yet
				end
				
				else begin
					state <= s1; // move to next state to begin checking
				end
			end 
			
			/*
			*	This state moves through the memory and looks for the specific password
			*	that was entered by the user. If no password is found then 
			*	the whole process is stopped and the User has to reset the game in order to 
			*	enter a new password. If a password is found, then a flag is sent to GameController module
			*	to let the user start playing
			*/
			s1: begin 
				if(check == stop) begin
					state <= sDone;
				end
				
				else begin
					if(check == password) begin
						flag <= 1;
						state <= s2;
					end
					
					address <= address + 1; 
					state <= s1; // proceed to the same state to check
					
				end // end else

			end // end s1

			/*
			*	This state checks to see what password was selected and display 
			*	the level out to the user
			*/
			s2: begin
				if(password == 16'h1234) begin
					displayLevel <= 7'b1111001; // display level 1
				end
				
				else if(password == 16'h1235) begin
					displayLevel <= 7'b0100100; // display level 2
				end
				
				else begin
					displayLevel <= 7'b0110000; // display level 3
				end
				
				state <= sDone; // move on to the end state
			end // end s2
			
			/*
			*	This state continues to output the level that the user selected
			*	if any level was selected at all. Else, it will output the 
			*	unchanged displayLevel 7'b0000110
			*/
			sDone: begin
				displayLevel <= displayLevel; // keep displaying the result
				flag <= flag;
				state <= sDone;
			end // end sDone
			
			/*
			*	This state is similar to the reset button being pushed
			*/
			default: begin
				flag <= 0;
				state <= sWait;
				displayLevel <= 7'b0000110;
				address <= 7'b0000000;	
			end // end of default
			
			endcase
		end
	
	
	end // end always@


endmodule
