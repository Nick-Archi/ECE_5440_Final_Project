module GameController(tog_start, time_out, done1, enable1, done2, enable2, LED, clk, rst);

input time_out, enable1, enable2, clk, rst;
input [2:0] done1, done2;
input [1:0] tog_start;

output reg [2:0] LED;


always @(tog_start) begin
	if(rst == 0) begin
		LED <= 3'b000;
	end
	else begin 
		case(tog_start)
			2'b00: begin
				if(time_out == 0 && enable1 == 1) begin
					LED <= done1;
					end
			end
			2'b01: begin
				if(time_out == 0 && enable1 == 1) begin
					LED <= done1;
				end
			end
			2'b11: begin
				if(time_out == 0 && enable2 == 1) begin
					LED <= done2;
				end
			end
			default: begin
				LED <= 3'b000;
			end
		endcase
	end
end
endmodule