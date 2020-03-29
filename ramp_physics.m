%%calculates the acceleration on the marble when on a ramp.
function [angular_acceleration, linear_acceleration] = ramp_physics(mass, gravity, ramp,angular_acceleration, linear_acceleration)

deltaX = abs(ramp.startX - ramp.endY);
deltaY = abs(ramp.startY - ramp.endY);
length = (deltaX^2 + deltaY^2)^(1/2);
theta = acos(-(deltaY^2-deltaX^2-length^2)/(2*deltaY*length));

sinT = sin(theta);
mg = mass*gravity;
mr = mass*radius;


angular_acceleration(3) = angular_acceleration(3) + -sinT*mg/(mr-2/5mr*radius);
linear_acceleration(1) = linear_acceleration(1) + cos(theta)*-sinT*mg/(mass-2/5*mr);
linear_acceleration(2) = linear_acceleration(2) + sinT*-sinT*mg/(mass-2/5*mr);