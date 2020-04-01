%%This updates position, velocity, and acceleration based on values from
%%last tick.
function [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(timestep,position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius)

        
        
        if ~col_occur
            position(2) = position(2) + linear_velocity(2)*timestep + 0.5*linear_acceleration(2)*(timestep)^2; %%divide by 10 because of our time interval
        end
        
        position(1) = position(1) + linear_velocity(1)*timestep + 0.5*linear_acceleration(1)*(timestep)^2; %%divide by 10 because of our time interval



        %angular_velocity(3) = angular_velocity(3) + angular_acceleration(3)/timestep;%%divide by 10 because of our time interval

    

        %linear_velocity(1) = angular_velocity(3)/radius/timestep;

    
        if ~col_occur
            linear_velocity(2) = linear_velocity(2) + linear_acceleration(2)*timestep; %%divide by 10 because of our time interval
        end


        linear_velocity(1) = linear_velocity(1) + linear_acceleration(1)*timestep; %%divide by 10 because of our time interval

    
end