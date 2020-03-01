%%A simulation to simulate a marble rolling down a track for MSE 222

clc; %%clears command window
        
%%constants
gravity = 9.806374046543; %%m/s^2
friction = 0.22;
mass = 0.02; %%kg

%%initial conditions
    %%(0,0) is the bottome left corner of the plate. 
xpos = 0; %%m
ypos = 0.6; %%m
    %%Linear values
xLinVelocity = 0; %%m/s
yLinVelocity = 0; %%m/s
xLinAcceleration = 0; %%m/s^2
yLinAcceleration = 0; %%m/s^2
    %%angular values
xAngVelocity = 0; %%m^2/s
yAngVelocity = 0; %%m^2/s
xAngAcceleration = 0; %%m^2/s^2
yAngAcceleration = 0; %%m^2/s^2
    %%forces
xForce = 0; %%(kg)(m/s^2)
yForce = 0; %%(kg)(m/s^2)

%% each second is 10 values for t. example: 20 seconds is t=200
for t = 0:400 %%400 chosen because if we get to this time something has gone horribly wrong
    
    %%line below is update_tick which updates everything based on previous
    %%conditions.
    [xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce] = update_tick(xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce);
    
    %%print output to command window
    fprintf("t= " + t/10 + ", x= " + xpos + ", y= " + ypos + ", xVelLin= " + xLinVelocity + ", yVelLin= " + yLinVelocity)
    fprintf(", xAccelLin= " + xLinAcceleration + ", yAccelLin= " + yLinAcceleration + ", xVelANG= " + xAngVelocity)
    fprintf(", yVelANG= " + yAngVelocity + ", xAccelANG= " + xAngAcceleration + ", yAccelANG = " + yAngAcceleration)
    fprintf(", xForce = " + xForce + ", yForce= " + yForce)
    fprintf(newline)
end
