%%detects if the sphere is in contact with a surface.
function [i,j] = detect_collision(position, map, radius)
    j = 0; %%need to init in case the first i value checked is outside the boundary area and j is never defined
    for i = position(1)-radius : position(1)+radius %%x values in a square around the marble
        if i > 0 && i < 601
             for j = position(2)-radius : position(2)+radius %%y values in a square around the marble
                 if j > 0 && j < 601
                    if map(i,j) == 1
                         fprintf("square collision detected!")
                         fprintf(newline)
                    end
                 else
                     fprintf("i component out of bounds! j = " + j + " position centre is: (" + position(1) + "," + position(2) + ")")
                     fprintf(newline)
                     return
                 end
             end
        else
            fprintf("i component out of bounds! i = " + i + " position centre is: (" + position(1) + "," + position(2) + ")")
            fprintf(newline)
            return
        end
    end
end