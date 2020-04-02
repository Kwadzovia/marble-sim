%%detects if the sphere is in contact with a surface.
function [out_of_bounds,collision_pos,col_occur,final_posx,final_posy] = detect_collision(position, ramp_listvar, radius, intervals, thickness,marble_handle)
    out_of_bounds = false;
    col_occur = false;
    
    final_posx = position(1);
    final_posy = position(2);
    
    a = [0:0.1:2*pi];
    circle_x = cos(a);
    circle_y = sin(a);

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
    
    for j = 1:1:intervals
        if norm([ramp_list_x(j)-position(1) ramp_list_y(j)-position(2)]) <= thickness+radius    
            col_occur = true;
            collision_pos = [ramp_list_x(j) ramp_list_y(j)];
            
            %%Special repositioning
            min_distance = 2*radius + thickness; %%Starting at max possible distance from collision point
            final_pos = [];
            for k=0:0.1:2*pi
               current_distance = norm([((position(1) + cos(k)*radius ) - collision_pos(1)) ((position(2) +  + sin(k)*radius) - collision_pos(2))]);
               if current_distance < min_distance
                   min_distance = current_distance;
                   collision_readjustment = [((position(1) + cos(k)*radius )) ((position(2) + sin(k)*radius))];
               end
            end
            
            col_theta = atan2((collision_readjustment(2)-collision_pos(2)),(collision_readjustment(1)-collision_pos(1)));
            tempdeg = radtodeg(col_theta)
            final_posx = (collision_pos(1)+cos(col_theta)*(thickness+4.7));
            final_posy = (collision_pos(2)+sin(col_theta)*(thickness+4.7));
            set(marble_handle,'XData',final_posx+radius*circle_x,'YData',final_posy+radius*circle_y)
            
            %%fprintf("collision detected at (" + ramp_list_x(j) + "," + ramp_list_y(j) + ")")
            %%fprintf(newline)
            return
        end

    end
    end
end
