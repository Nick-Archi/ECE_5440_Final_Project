/* 	Module: CheckUser
*
* 	Description: Takes the user’s ID and checks the memory in order to access the user’s specified level. 
*	The end of our memory will be signified with a 
*	‘F’, if the address hits this and there has been no match with the user’s password, 
*	then the level will be given a default
*
*	Created By: Nicholas
*
*/

module CheckUser(user, load, speed, userLog, clk, rst);

	/* inputs
	*	user = 4 bit password from the user
	*	load = load signal from GameController module that goes high when a button is pressed
	*	clk
	*	rst
	*/	
	input[3:0] user;
	input load, clk, rst;
	
	/* output reg
	*	speed = 
	*	userLog = flag that will be fed to the GameController when doing verifying
	*/	
	output reg[1:0] speed;
	output reg userLog;


	/* reg
	*	state = FSM controller
	*/	
	reg[2:0] state;


	/* parameter
	*	FSM states
	*/		
	parameter sWait = 0, s1 = 1, s2 = 2, sDone = 3;
	
	
	// ***** setting up of the ROM module
	
	/*	reg
	*	address = 8 bit address in the ROM
	*/
	reg[7:0] address; 

	/*	wire
	*	verify = 4 bit password in the ROM memory
	*/	
	wire[3:0] verify;
	
	/*	parameter
	*	stop = the END value in memory
	*/		
	parameter[3:0] stop = 4'b1111; // corresponds to an 'F'
	
	/* other module
	*	myROM 
	*/
	myROM ROM(address, clk, verify);
	

	always@(posedge clk) begin
		
		if(rst == 0) begin
			state <= sWait;
			speed <= 2'b00;
			userLog <= sWait;
			address <= 0;
		end // end of if


		/*
		*	Creation of the memory controller portion that will move through the address in 
		*	the ROM and verify if the user's password is in one of them
		*/			
		else begin
	
			case(state) 
				
				sWait: begin
					if(load == 0) begin // input not received from the GameController
						state <= sWait;
					end
					
					else begin
						state <= s1;
					end
				end // end of sWait
				
				s1: begin
					if(verify == stop) begin // if you hit the end
						speed <= 2'b00; // set to default speed
						state <= sDone;												
						end // end of if
						
					else begin						
						if(verify == user) begin // if you get a hit on the right password
							state <= s2;
						end // end of if
						
						else begin // stay in same state but move up in the address
							address <= address + 1;
							state <= s1; 
						end // end of else
						
					end // end of else
										
				end // end of s1
				
				s2: begin
					case(verify)
						
						1: begin // normal
							speed <= 2'b00;
						end
						
						2: begin // intermediate
							speed <= 2'b01;
						end

						3: begin // advanced
							speed <= 2'b10;
						end

						default: begin // default so that the speed is set to the normal value
							speed <= 2'b00;
						end						
																
					endcase
					
					// end of the selection and speed should be set accordingly...					
					state <= sDone;
					
				end // end of s2
				
				sDone: begin
					userLog <= 1; // set to 1 b/c process is done
					speed <= speed; // keep outputting the speed
					state <= sDone;
				end // end of sDone
				
				default: begin // default same as the reset stage
					state <= sWait;
					speed <= 2'b00;
					userLog <= sWait;
					address <= 0;					
				end // end of default

			endcase			
			
		end // end of else

	end // end of always@

endmodule