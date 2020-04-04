%%This updates position, velocity, and acceleration based on values from
%%last tick.
function [ old_position, position, marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(fps,position,marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius)

        %%time is 1/fps

        old_position = position;
        

        position(2) = position(2) + linear_velocity(2)*1/fps + 0.5*linear_acceleration(2)*(1/fps)^2; 

        
        position(1) = position(1) + linear_velocity(1)*1/fps + 0.5*linear_acceleration(1)*(1/fps)^2;

        marble_angle = marble_angle + angular_velocity/fps + 0.5*angular_acceleration*(1/fps)^2;

        %angular_velocity = angular_velocity+ angular_acceleration;
        %linear_velocity(1) = angular_velocity(3)/radius;
  

       linear_velocity(2) = linear_velocity(2) + linear_acceleration(2)*1/fps;

       linear_velocity(1) = linear_velocity(1) + linear_acceleration(1)*1/fps;
       

    
end