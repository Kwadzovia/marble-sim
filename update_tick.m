%%This updates position, velocity, and acceleration based on values from
%%last tick.
function [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius)

    time_division_factor = 100;

    if linear_velocity(2) ~= 0 %%if y linear velocity is not zero then add that velocity to y position
        position(2) = position(2) + linear_velocity(2)/time_division_factor; %%divide by 10 because of our time interval
    end
    
    if linear_velocity(1) ~= 0 %%if x linear velocity is not zero then add that velocity to x position
        position(1) = position(1) + linear_velocity(1)/time_division_factor; %%divide by 10 because of our time interval
    end

    if angular_acceleration(3) ~= 0 %%if y angular acceleration is not zero then add that acceleration to y angular velocity
        angular_velocity(3) = angular_velocity(3) + angular_acceleration(3)/time_division_factor;%%divide by 10 because of our time interval
    end
    
    if (angular_velocity(3) ~= 0 && col_occur)
        linear_velocity(1) = angular_velocity(3)/radius/time_division_factor;
    end
    
    if linear_acceleration(2) ~= 0 %%if y linear acceleration is not zero then add that acceleration to y linear velocity
        linear_velocity(2) = linear_velocity(2) + linear_acceleration(2)/time_division_factor; %%divide by 10 because of our time interval
    end

    if linear_acceleration(1) ~= 0 %%if x linear acceleration is not zero then add that acceleration to x linear velocity
        linear_velocity(1) = linear_velocity(1) + linear_acceleration(1)/time_division_factor; %%divide by 10 because of our time interval
    end
    
end