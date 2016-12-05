module StartGame(pwAccepted,togStart,go,clk,reset);
	input pwAccepted, togStart, clk, reset;
	output go;
	
	always @(posedge clk) begin
		if(reset==0) begin
			go<=0;
		end
		else begin
			if(pwAccepted==1 && togStart==1) begin
				go<=1;
			end
		end
		
	end
endmodule