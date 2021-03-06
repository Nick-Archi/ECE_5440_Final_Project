/* 	Module: split7seg
*
* 	Description: Splits the input and then feeds two outputs into 2 Seven Segment 
*	Display modules that will then display the correct 2-digit number. 
*
*	Created By: Robert
*/

module split7seg(wholeNum, rightDigit, leftDigit);

	/* inputs
	*	
	*/	
	input[6:0] wholeNum;
	
	/* output reg
	*	
	*/
	output reg[3:0] rightDigit, leftDigit;
	
	always@(wholeNum) begin
	
		rightDigit = wholeNum % 10;
		leftDigit = (wholeNum - rightDigit) / 10;

	end
	
endmodule
