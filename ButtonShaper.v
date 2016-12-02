module ButtonShaper(Button, B_Out, Clock, Reset);

    input Button, Clock, Reset;
    output Bout;
    reg Bout;
    
    reg [3:0] State;
    parameter S_On0 = 0, S_On1 = 1, S_On2 = 2;
    
    always@(posedge Clock) begin
        if (Reset == 0) begin
            State <= S_On0;
        end     
        else begin
            case(State)
                S_On0: begin		
	    		B_out <= 0;
	    		if (Button == 0) begin
	     			State <= S_On1;
                    	end
	                else begin			  
	     			State <= S_On0;
		        end
                end
                
                S_On1: begin
                	B_Out <= 1;
                    	State <= S_On2;
                end
                
                S_On2: begin
                    	B_Out <= 0;
                    	if (Button == 0) begin
                        	State <= S_On0;
                    	end
                    	else begin
                        	State <= S_On2;
                    	end
                end
            endcase
        end
    end
endmodule
          
