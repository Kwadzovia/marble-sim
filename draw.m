function [] = draw(position)
r = 20

theta = linspace(0,2*pi);
x = r*cos(theta) + position(1);
y = r*sin(theta) + position(2);
plot(x,y)
pbaspect([1,1,1])
axis([0 600 0 600])

end 