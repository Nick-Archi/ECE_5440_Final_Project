module GameController(tog_start, time_out, done, enable, LED, clk, rst);

input time_out, enable, clk, rst;
input [2:0] done;
input [1:0] tog_start;

output reg [2:0] LED;


always @(posedge clk) begin
	if(rst == 0) begin
		LED <= 3'b000;
	end
	else begin 
		case(tog_start)
			2'b00: begin
				if(time_out == 0 && enable == 1) begin	//level: Normal
					LED <= done;
					end
			end
			2'b01: begin
				if(time_out == 0 && enable == 1) begin //level: Intermediate
					LED <= done;
				end
			end
			2'b11: begin
				if(time_out == 0 && enable == 1) begin //level: Advance
					LED <= done;
				end
			end
			default: begin
				LED <= 3'b000;
			end
		endcase
	end
end
endmodule