%%This updates position, velocity, and acceleration based on values from
%%last tick.
function [xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce] = update_tick(xpos, ypos, xLinVelocity, yLinVelocity, xLinAcceleration, yLinAcceleration, xAngVelocity, yAngVelocity, xAngAcceleration, yAngAcceleration, xForce, yForce)

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