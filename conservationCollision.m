%impact on a flat surface. inputs are linear & angular velocities, impact time, gravity, mass, radius, impact force
%%returns new linear & angular accelerations

function [impacted,linAccel,angAccel,linVel,angVel] = conservationCollision(linVel,angVel,linAccel,angAccel,radius,restitution,ramp_list,collided_ramp,position,collision_position)

ybar =  position(2) - collision_position(2);
xbar =  position(1) - collision_position(1);

ybar = ybar/1000;
xbar = xbar/1000;



current_ramp = ramp_list{collided_ramp};
ramp_direction = [current_ramp(2,1)-current_ramp(1,1) current_ramp(2,2)-current_ramp(1,2)];
temp_theta = atan2(ramp_direction(2),ramp_direction(1));

rotation_vector = [cos(temp_theta) -sin(temp_theta); sin(temp_theta) cos(temp_theta)];

temp_rotation = rotation_vector*[xbar;ybar];
xbar = temp_rotation(1);
ybar = temp_rotation(2);

temp_rotation = rotation_vector*[linVel(1);linVel(2)];
linVel(1) = temp_rotation(1);
linVel(2) = temp_rotation(2);

% omega1 = angVel;
% omega2 = -(linVel(1)+0.4*omega1*radius*cos(temp_theta))/(-radius-0.4*radius*cos(temp_theta));

% omega2 = (linVel(1)*ybar+linVel(2)*xbar -2/5*radius^2*angVel + restitution*linVel(2)*xbar)/(radius+0.4*radius^2)

omega2 = 5/7*(linVel(1)-2/5*angVel*radius);
linVel(1) = -omega2*radius;
linVel(2) = -restitution*linVel(2);

rotation_vector = [cos(-temp_theta) -sin(-temp_theta); sin(-temp_theta) cos(-temp_theta)];
temp_rotation = rotation_vector*[linVel(1);linVel(2)];
linVel(1) = temp_rotation(1);
linVel(2) = temp_rotation(2);

% combined = norm(linVel);
% 
% if cos(temp_theta) == 0
%     linVel = [linVel(2) linVel(1)]
% else
% linVel(1) = 1000*combined*sin(temp_theta);
% linVel(2) = 1000*combined*cos(temp_theta);
% end














angVel = omega2;
linAccel(1) = 0;
impacted = 1;



end

