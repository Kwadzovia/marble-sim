%%detects if the sphere is in contact with a surface.
function out_of_bounds = detect_collision(position, map, radius)
    out_of_bounds = false;
    
    theta = linspace(0,2*pi,100); %creates 100 evenly spaced points between 0 and 2*pi;
    x = radius*cos(theta) + position(1);
    y = radius*sin(theta) + position(2);
    
    for i = 1:length(x)
        if x(i) > 0.5 && x(i) < 602
            for j = 1:length(y)
                if y(j) > 0.5 && y(j) < 602
                    if map(int16(x(i)),int16(y(j))) == 1
                            fprintf("collision detected")
                            fprintf(newline)
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
