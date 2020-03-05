%%draws the sphere
function [] = draw(position)

r = 20;
theta = linspace(0,2*pi,100); %creates 100 evenly spaced points between 0 and 2*pi
x = r*cos(theta) + position(1);
y = r*sin(theta) + position(2);

plot(x,y);
pbaspect([1,1,1]); %sets aspect ratio to 1:1
axis([0 600 0 600]); %sets plot size to 600 by 600
pause(0.001) %%done so we can actually see whats happening

end 