%%circular physics. returns lin accel and angular accel
function [accel, angular] = circle_physics(position)
%%inits
r = 990;
marbr = 5/1000;
g = -9.806374;
friction = 0.22;
centre = [260 1500];

%%section might be useless
endpositionx = 40;
endpositiony = 510;
deltaxend = centre(1) - endpositionx;
deltayend = centre(2) - endpositiony;
thetaend = tan(deltayend/deltaxend);

%%determinging theta
deltaxstart = centre(1)-position(1);
deltaystart = centre(2)-position(2);
thetastart = tan(deltaystart/deltaxstart);

%%accel calculations
accelx = 1000*friction*g*cos(thetastart)*cos(thetastart)/2*5;
accely = 1000*friction*g*cos(thetastart)*sin(thetastart)/2*5;
angular = accelx/marbr;
accel = [accelx, accely];

end
