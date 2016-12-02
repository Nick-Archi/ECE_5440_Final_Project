module TimerSpeed(Level, GameSpeed, Clock, Reset);

    input [1:0] Level, 
    input Clock, Reset;
    output [1:0] GameSpeed;
    reg [1:0] GameSpeed
    
    reg [3:0] State;
    parameter S_Normal = 0, S_Intermediate = 1, S_Advanced = 2;
    
    always@(posedge Clock) begin
        if (Reset == 0) begin
            GameSpeed <= 2'b00;
            State <= S_Normal;
        end
        
        else begin
            case (State)
                S_Normal: begin
                    if (Level == 2'b00)
                        GameSpeed <= 2'b00;
                        
                
