%%detects if the sphere is in contact with a surface.
function [out_of_bounds,forceX,forceY,col_occur] = detect_collision(position, radius, ramp)
    
    theta = linspace(pi,2*pi/2,50)
    x = int16(radius*cos(theta)) + position(1);
    y = int16(radius*sin(theta)) + position(2);
    
    
    for i = 1:2
        if (x < position(1)) and (x > position(1))
        for j = 1:50
            ytemp = ramp(i,x(j))
            if (ytemp - y(j)) < 1 %arbitrary distance probably pretty small

        end
    end
end
