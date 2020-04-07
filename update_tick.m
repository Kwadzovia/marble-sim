%%This updates position, velocity, and acceleration based on values from
%%last tick.
function [ old_position, position, marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(mass,fps,position,marble_angle,gravity, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius_m, ramp_list,collided_ramp)

    %%time is 1/fps
    
    old_position = position;
    
    if col_occur
       current_ramp = ramp_list{collided_ramp};
       ramp_direction = [current_ramp(2,1)-current_ramp(1,1) current_ramp(2,2)-current_ramp(1,2)];
       temp_theta = atan2(ramp_direction(2),ramp_direction(1));
       
       
        old_angular_velocity = angular_velocity;
        old_linear_velocity = linear_velocity;

        if collided_ramp ~= 4 %non flat surface
            
            if collided_ramp == 15
                  [linear_acceleration angular_acceleration] = circle_physics(position)
            else
                  linear_acceleration(1) = cos(temp_theta)*gravity*sin(temp_theta)/(1+(sqrt(2/5*radius_m^2))^2/radius_m^2)*1000;
                  linear_acceleration(2) = sin(temp_theta)*gravity*sin(temp_theta)/(1+(sqrt(2/5*radius_m^2))^2/radius_m^2)*1000;
                  angular_acceleration = -(1/radius_m)*gravity*sin(temp_theta)/(-0.6)*1000;
            end
        end

        angular_velocity = old_angular_velocity + angular_acceleration/fps;
        linear_velocity(1) = old_linear_velocity(1) + linear_acceleration(1)/(fps);
        linear_velocity(2) = old_linear_velocity(2) + linear_acceleration(2)/(fps);
        
        position(2) = position(2) + linear_velocity(2)*1/fps + 0.5*linear_acceleration(2)*(1/fps)^2;
        position(1) = position(1) + linear_velocity(1)*1/fps + 0.5*linear_acceleration(1)*(1/fps)^2;
        marble_angle = marble_angle + angular_velocity/fps + 0.5*angular_acceleration*(1/fps)^2;
    
    else

    position(2) = position(2) + linear_velocity(2)*1/fps + 0.5*linear_acceleration(2)*1000*(1/fps)^2;
    position(1) = position(1) + linear_velocity(1)*1/fps + 0.5*linear_acceleration(1)*1000*(1/fps)^2;
    marble_angle = marble_angle + angular_velocity/fps + 0.5*angular_acceleration*(1/fps)^2;

    angular_velocity = angular_velocity+ angular_acceleration*1/fps;
    linear_velocity(2) = linear_velocity(2) + linear_acceleration(2)*1000*1/fps;
    linear_velocity(1) = linear_velocity(1) + linear_acceleration(1)*1000*1/fps;


    end

end