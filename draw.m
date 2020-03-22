%%draws the sphere
function [] = draw(position, radius)

    [x,y] = discreet_cart_circle(position, radius);

    plot(x,y);
    pbaspect([1,1,1]); %sets aspect ratio to 1:1
    axis([0 600 0 600]); %sets plot size to 600 by 600

end 