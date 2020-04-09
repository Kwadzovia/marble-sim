%%circular physics. returns lin accel and angular accel
function [accel, angular] = circle_physics(position,old_position,velocity)
%%inits
r = 990/1000;
marbr = 5/1000;
g = 9.806374;
friction = 0.22;
center = [260 1500];

    
%%section might be useless
% endpositionx = 40;
% endpositiony = 510;
% deltaxend = center(1) - endpositionx;
% deltayend = center(2) - endpositiony;
% thetaend = tan(deltayend/deltaxend);
% 
% %%determinging theta
% deltaxstart = center(1)-position(1);
% deltaystart = center(2)-position(2);
% thetastart = atan(deltaystart/deltaxstart)+pi/2;

rot_angle = deg2rad(90);
rotation_vector = [cos(rot_angle) sin(rot_angle);-sin(rot_angle) cos(rot_angle)];

temp_dir = [position(1)-center(1) position(2)-center(2)];
unit_dir= temp_dir/norm(temp_dir);

tangential_dir = rotation_vector*[unit_dir(1);unit_dir(2)];
tangential_dir = [tangential_dir(1) tangential_dir(2)];


theta = atan2(temp_dir(2),temp_dir(1))
tangentialAcc = -5/7*g*sin(theta);

centripetalSpeed = 10/7*(7/10*norm([velocity]/1000)^2 + g*(old_position(2)/1000-position(2)/1000));
centripetalAcc = centripetalSpeed/r;

accelx = abs(tangentialAcc)*tangential_dir(1) + abs(centripetalAcc)*-unit_dir(1);
accely = abs(tangentialAcc)*tangential_dir(2) + abs(centripetalAcc)*-unit_dir(2);


accelx = 1000*accelx;
accely = 1000*accely;
angular = -accelx/(1000*marbr);
accel = [accelx, accely];
    
end
