%impact on a flat surface. inputs are linear & angular velocities, impact time, gravity, mass, radius, impact force
%%returns new linear & angular accelerations 

function [linAccel,angAccel,linVel,angVel] = impact(linVel,angVel,linAccel,angAccel,impactT,gravity,mass,radius,impactF,friction)
MOI=(2/5)*mass*radius^2; %%moment of inertia

%assume no slipping:
Ff=(MOI*impactF)/(MOI-radius^2);%%force of friction

linAccel(1)=(impactF-Ff)/mass;
angAccel(3)=linAccel(1)/radius;

%resulting velocities via kinematic equations    
angVel(3)=angVel(3)+angAccel(3)*impactT;
linVel(1)=linVel(1)+linAccel(1)*impactT;

end

    