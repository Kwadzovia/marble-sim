%%A simulation to simulate a marble rolling down a track for MSE 222

%%Commands for this program:
    %%update(conditions) updates all positions, velocities, and
        %%accelerations based on previous conditions

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
xLinVelocity = 1; %%m/s
yLinVelocity = 0; %%m/s
xLinAcceleration = 1;
yLinAcceleration = 0;
    %%angular values
xAngVelocity = 0; %%m^2/s
yAngVelocity = 0; %%m^2/s
xAngAcceleration = 0;
yAngAcceleration = 0;
    %%forces
xForce = 0;
yForce = 0;

conditions = [xpos ypos xLinVelocity yLinVelocity xLinAcceleration yLinAcceleration xAngVelocity yAngVelocity xAngAcceleration yAngAcceleration xForce yForce];

%% each second is 10 values for t. example: 20 seconds is t=200
for t = 0:400 %%400 chosen because if we get to this time something has gone horribly wrong
    [xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce] = update(xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce);
    %%print output to command window
    fprintf("t= " + t/10 + ", x= " + xpos + ", y= " + ypos + ", xVelLin= " + xLinVelocity + ", yVelLin= " + yLinVelocity)
    fprintf(", xAccelLin= " + xLinAcceleration + ", yAccelLin= " + yLinAcceleration + ", xVelANG= " + xAngVelocity)
    fprintf(", yVelANG= " + yAngVelocity + ", xAccelANG= " + xAngAcceleration + ", yAccelANG = " + yAngAcceleration)
    fprintf(", xForce = " + xForce + ", yForce= " + yForce)
    fprintf(newline)
end

function [xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce] = update(xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce)
    %%test

    if yLinVelocity ~= 0 %%if y linear velocity is not zero then add that velocity to y position
        ypos = ypos + yLinVelocity/10; %%divide by 10 because of our time interval
    end
    
    if xLinVelocity ~= 0 %%if x linear velocity is not zero then add that velocity to x position
        
        xpos = xpos + xLinVelocity/10; %%divide by 10 because of our time interval
    end

    if yAngAcceleration ~= 0 %%if y angular acceleration is not zero then add that acceleration to y angular velocity
        yAngVelocity = yAngVelocity + yAngAcceleration/10; %%divide by 10 because of our time interval
    end

    if xAngAcceleration ~= 0 %%if x angular acceleration is not zero then add that acceleration to x angular velocity
        xAngVelocity = xAngVelocity + xAngAcceleration/10; %%divide by 10 because of our time interval
    end

    if yLinAcceleration ~= 0 %%if y linear acceleration is not zero then add that acceleration to y linear velocity
        yLinVelocity = yLinVelocity + yLinAcceleration/10; %%divide by 10 because of our time interval
    end

    if xLinAcceleration ~= 0 %%if x linear acceleration is not zero then add that acceleration to x linear velocity
        xLinVelocity = xLinVelocity + xLinAcceleration/10; %%divide by 10 because of our time interval
    end

end