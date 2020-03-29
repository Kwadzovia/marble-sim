%%calculates the acceleration on the marble when on a ramp.
function [angular_acceleration, linear_acceleration] = ramp_physics(mass, gravity, radius, ramp,angular_acceleration, linear_acceleration)

    deltaX = abs(ramp.startX - ramp.endX);
    deltaY = abs(ramp.startY - ramp.endY);
    length = (deltaX^2 + deltaY^2)^(1/2);

    if(deltaX ~= 0 && deltaY ~= -0)
        theta = acos(-(deltaY^2-deltaX^2-length^2)/(2*deltaY*length));
    else
        theta = 0;
    end

    sinT = sin(theta);
    mg = mass*gravity;
    mr = mass*radius;
    mgsinT = sinT*mg;

    angular_acceleration(3) =  -mgsinT/(mr-2/5*mr*radius);
    linear_acceleration(1) = cos(theta)*-mgsinT/(mass-2/5*mr);
    linear_acceleration(2) = sinT*-mgsinT/(mass-2/5*mr);
end