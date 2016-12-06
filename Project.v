module Project(clk,rst,regIn,bIn1,bIn2,bIn3,scoreSegLeft,scoreSegRight,timerSegLeft,timerSegRight,led1,led2,led3);

	input clk,rst,bIn1,bIn2,bIn3;
	input[3:0] regIn;
	output[6:0] scoreSegLeft,scoreSegRight,timerSegLeft,timerSegRight;
	output led1,led2,led3;
	
	wire b_Out1,b_Out2,b_Out3;//button shaper signals 
	wire userLoad,loadOut,userLog,startGame,ms100,stop,change;
	wire bOut1,bOut2,bOut3;//button signals from game controller
	wire[3:0] regOut;
	wire[1:0] speed,randNum;
	wire[6:0] score,timeOut;
	wire[3:0] scoreLSeg, scoreRSeg,timeLSeg,timeRSeg;
	
	ButtonShaper button1(bIn1, b_Out1, rst, clk);
	ButtonShaper button2(bIn2, b_Out2, rst, clk);
	ButtonShaper button3(bIn3, b_Out3, rst, clk);
	
	GameController myGameController(rst,clk,b_Out1,b_Out2,b_Out3,userLog,stop,userLoad,startGame,bOut1,bOut2,bOut3);
	Register myRegister(regIn, regOut, clk, rst,userLoad,loadOut);
	CheckUser myCheckUser(regOut, loadOut, speed, userLog, clk, rst);
	LFSR100ms myLFSR100ms(rst, clk,startGame, ms100);
	speedCount myspeedCount(rst, clk,startGame,speed,ms100,change);
	TimerCountDown myTimerCountDown(clk, rst, startGame, ms100, timeOut, stop);
	LED_Score myLED_Score(change, startGame, bOut1,bOut2,bOut3, randNum, clk, rst, led1, led2, led3, score);
	RandomNumGen myRandomNumGen(randNum,clk,rst);
	
	split7seg scoreSegSplit(score, scoreRSeg, scoreLSeg);
	split7seg timeSegSplit(timeOut, timeRSeg, timeLSeg);
	
	SegDisplay scoreLeft(scoreLSeg,scoreSegLeft);
	SegDisplay scoreRight(scoreRSeg,scoreSegRight);
	SegDisplay timeLeft(timeLSeg,timerSegLeft);
	SegDisplay timeRight(timeRSeg,timerSegRight);
	
endmodule