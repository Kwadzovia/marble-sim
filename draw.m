%%draws the sphere
function [] = draw(position, radius)

theta = linspace(0,2*pi,100); %creates 100 evenly spaced points between 0 and 2*pi
x = radius*cos(theta) + position(1);
y = radius*sin(theta) + position(2);

plot(x,y);
pbaspect([1,1,1]); %sets aspect ratio to 1:1
axis([0 600 0 600]); %sets plot size to 600 by 600

end 