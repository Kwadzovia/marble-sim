%%returns 2 arrays of x and y coordinates for the bounding box of a circle
%%centered on a point with a given radius.
function [x,y] = discreet_cart_circle(position, radius)
    
    theta = linspace(0,2*pi,100); %creates 100 evenly spaced points between 0 and 2*pi
    x = int16(radius*cos(theta)) + position(1);
    y = int16(radius*sin(theta)) + position(2);
end