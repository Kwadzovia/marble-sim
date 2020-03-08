%%handles all types of collision. (probably) calls other functions
function [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = collision_handle(colX, colY, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration)

        %%do some mathy stuff, these values are just placeholder for
        %%testing
        if colY < position(2) %%if collision was below the centre
            linear_acceleration(2) = 0;
            linear_velocity(2) = 0;
        end
        %%if collision was to the right of the sphere and the acceleration was in that direction
        if colX > position(1) && linear_acceleration(1)>0
            linear_acceleration(1) = -linear_acceleration(1); %invert the acceleration
            linear_velocity(1) = 0; %reset velocity
        end
        %%if collision was to the left of the sphere and the acceleration was in that direction
        if colX < position(1) && linear_acceleration(1)<0
            linear_acceleration(1) = -linear_acceleration(1); %%invert the acceleration
            linear_velocity(1) = 0; %%reset velocity
        end

end