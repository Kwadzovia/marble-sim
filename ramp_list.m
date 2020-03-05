%%returns a list of all ramps in the map. Each ramp contains a list of
%%start and end positions, and friction
function [list] = ramp_list()

    %%ramp 1
    ramp(1).startX = 100;
    ramp(1).startY = 500;
    ramp(1).endX = 300;
    ramp(1).endY = 400;
    ramp(1).friction = 0;
    
    %%ramp2
    ramp(2).startX = 400;
    ramp(2).startY = 300;
    ramp(2).endX = 150;
    ramp(2).endY = 200;
    ramp(2).friction = 0;
    
    for i = 1:length(ramp)
        list(i) = ramp(i);
    end
end
