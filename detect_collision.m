%%detects if the sphere is in contact with a surface.
function [out_of_bounds,collision_pos,col_occur] = detect_collision(position, ramp_listvar, radius)
    out_of_bounds = false;
    col_occur = false;
    
    intervals = 200;
    thickness = 2;
    collision_pos = [];
    for i = 1:1:length(ramp_listvar)
    ramp_list_x = linspace(ramp_listvar(i).startX,ramp_listvar(i).endX,intervals);
    ramp_list_y = linspace(ramp_listvar(i).startY,ramp_listvar(i).endY,intervals);
    
    if position(1) - radius < 0
        position(1) = 0 + radius;
        out_of_bounds = true;
        return
    end
    if position(1) + radius > 600
        position(1) = 600 - radius;
        out_of_bounds = true;
        return
    end
    
    %%Y Check
    if position(2) - radius < 0
        position(2) = 0 + radius;
        out_of_bounds = true;
        return
    end
    if position(2) + radius > 600
        position(2) = 600 - radius;
        out_of_bounds = true;
        return
    end
    
    if position(2) < 501
        pause(1)
    end
    for j = 1:1:intervals
        if norm([ramp_list_x(j)-position(1) ramp_list_y(j)-position(2)]) <= thickness+radius    
            col_occur = true;
            collision_pos = [ramp_list_x(j) ramp_list_y(j)];
            %%fprintf("collision detected at (" + ramp_list_x(j) + "," + ramp_list_y(j) + ")")
            %%fprintf(newline)
            return
        end

    end
    end
end
