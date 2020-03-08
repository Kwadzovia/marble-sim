%%detects if the sphere is in contact with a surface.
function [out_of_bounds,colX,colY,col_occur] = detect_collision(position, map, radius)
    out_of_bounds = false;
    col_occur = false;
    colX = 0;
    colY = 0;
    
    theta = linspace(0,2*pi,100); %creates 100 evenly spaced points between 0 and 2*pi;
    x = int16(radius*cos(theta)) + position(1);
    y = int16(radius*sin(theta)) + position(2);
    
    for i = 1:length(x)
        if x(i) > 0 && x(i) < 602
            for j = 1:length(y)
                if y(j) > 0 && y(j) < 602
                    if map(x(i),y(j)) == 1
                            fprintf("collision detected at (" + x(i) + "," + y(j) + ")")
                            fprintf(newline)
                            col_occur = true;
                            colX = x(i);
                            colY = y(j);
                            return
                    end
                else
                     fprintf("y component out of bounds! y = " + y(j) + " position centre is: (" + position(1) + "," + position(2) + ")")
                     fprintf(newline)
                     out_of_bounds = true;
                     return
                end
            end
        else
            fprintf("x component out of bounds! x = " + x(i) + " position centre is: (" + position(1) + "," + position(2) + ")")
            fprintf(newline)
            out_of_bounds = true;
            return
        end
    end
end
