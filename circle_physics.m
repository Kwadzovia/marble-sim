%%circular physics
function [v] = circle_physics(position, velocity)
r = 990;
g = 9.81;
centre = [260 1500];
endpositionx = 40;
endpositiony = 510;
deltaxend = centre(1) - endpositionx;
deltayend = centre(2) - endpositiony;
thetaend = tan(deltayend/deltaxend);

deltaxstart = centre(1)-position(1);
deltaystart = centre(2)-position(2);
thetastart = tan(deltaystart/deltaxstart);


v(1) = 10*r*g*sin(thetastart)/7 + velocity;




end
