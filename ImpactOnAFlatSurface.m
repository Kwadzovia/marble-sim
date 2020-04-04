%impact on a flat surface. inputs are linear & angular velocities, impact time, gravity, mass, radius, impact force
%%returns new linear & angular accelerations

function [linAccel,angAccel,linVel,angVel] = ImpactOnAFlatSurface(linVel,angVel,linAccel,angAccel,impactT,gravity,mass,radius,impactF,friction,restitution)
MOI=(2/5)*mass*radius^2; %%moment of inertia



%assume no slipping:
Ff=(MOI*impactF)/(MOI-radius^2);%%force of friction

linAccel(1)=(impactF-Ff)/mass;

%
% %resulting velocities via kinematic equations
angVel=angVel+angAccel*impactT;
linVel(1)=linVel(1)+linAccel(1)*impactT;



end

