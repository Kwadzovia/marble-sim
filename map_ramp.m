%%given a list of ramps and the map, changes positions the ramp occupies to
%%1s in map
function map = map_ramp(ramp_list, map)
    for a = 1:length(ramp_list) %%goes through each ramp
      m = (ramp_list(a).endY - ramp_list(a).startY)/(ramp_list(a).endX - ramp_list(a).startX); %%slope
        b = ramp_list(a).startY - m*(ramp_list(a).startX); %%y-intercept
    
        %%outputs equations of line to command window
        fprintf("Ramp " + a + " is y = " + m + "x + " + b);
        fprintf(newline);
    
        for i = min(ramp_list(a).startX, ramp_list(a).endX) : max(ramp_list(a).startX, ramp_list(a).endX) %%only check within bounds of the line
            for j = min(ramp_list(a).startY, ramp_list(a).endY) : max(ramp_list(a).startY, ramp_list(a).endY) %%only check within bounds of the line
                if m*i + b == j %%if the value of i satisfies the line equation then this point is on the line
                    map(i,j) = 1;
                end
            end
        end
    end
end