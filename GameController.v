module GameController(rst,clk,bIn1,bIn2,bIn3,userLog,stopIn,userLoad,startGame,bOut1,bOut2,bOut3);
	input rst,clk,bIn1,bIn2,bIn3,userLog,stopIn;
	output reg userLoad,startGame,bOut1,bOut2,bOut3;
	
	parameter waitUser=0,waitStart=1,waitStop=2,stop=3;
	reg[1:0] state;
	
	always @(posedge clk)begin
		if(rst==0)begin
			//all outputs are set low and initial state is pushed to waitUser
			userLoad<=0;
			startGame<=0;
			bOut1<=0;
			bOut2<=0;
			bOut3<=0;
			state<=waitUser;
		end
		else begin
			case(state)
				waitUser:begin//waiting for button 1 press to send load signal for user login
					if(bIn1==1)begin 
						userLoad<=1;//userLoad sends pulse for 1 clk cycle
						state<=waitStart;
					end
				end
				waitStart:begin//waiting for button 1 press to start game
					userLoad<=0;//setting userLoad low
					if(userLog==1)begin//checks that userLog is high
						if(bIn1==1)begin//button 1 press starts game
							startGame<=1;//startGame is high till stop signal is recieved 
							state<=waitStop;
						end
					end
				end
				waitStop:begin
					if(stopIn==1)begin//if stop signal high, game is stopped
						state<=stop;
						startGame<=0;
					end
					else begin 
						if(bIn1==1)begin//if button 1 pressed, bOut1 high else low
							bOut1<=1;
						end
						else begin
							bOut1<=0;
						end
						
						if(bIn2==1)begin//if button 2 pressed, bOut2 high else low
							bOut2<=1;
						end
						else begin
							bOut2<=0;
						end
						
						if(bIn3==1)begin//if button 3 pressed, bOut3 high else low
							bOut3<=1;
						end
						else begin
							bOut3<=0;
						end
					end
					
				end
				stop: begin
					if(bIn1==1)begin//button 1 press sends back to waitStart to play again
						state<=waitStart;
					end
				end
				
				default:begin
				//all outputs are set low and initial state is pushed to waitUser
				userLoad<=0;
				startGame<=0;
				bOut1<=0;
				bOut2<=0;
				bOut3<=0;
				state<=waitUser;
				end
			endcase
		end
	end
endmodule
