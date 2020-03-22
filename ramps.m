function [y,dy] = ramps(i,x)  

    ramp(1).startX = 100;
    ramp(1).endX = 300;
    ramp(1).equation = symfun(-()*x + 600, x)
    ramp(1).slope = diff(ramp(1).equation)
    
    ramp(2).startX = 400;
    ramp(2).endX = 150;
    ramp(2).equation = symfun(x - 100,x)
    ramp(2).slope = diff(ramp(2).equation)
    
    y = ramp(i).equation(x)
    dy = ramp(i).slope(x)
    
end