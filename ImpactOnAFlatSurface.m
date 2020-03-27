%impact on a flat surface

impact(0,0,0.07,9.81,0.002711,0.0065,1,0.7,0.6)

function [linAccel,angAccel,linVel,angVel] = impact(initLinVel,initAngVel,impactT,gravity,mass,radius,impactF,Ustatic,Ukinetic)
MOI=(2/5)*mass*radius^2;
%first assume no slipping:
Ff=(MOI*impactF)/(MOI-radius^2);
%check assumption
if Ff<=Ustatic*mass*gravity %if no slipping
    linAccel=(impactF-Ff)/mass;
    angAccel=linAccel/radius;
else
    Ff=Ukinetic*mass*gravity; % if slipping
    linAccel=(impactF-Ff)/mass;
    angAccel=(-Ff*radius)/MOI;
end
%resulting velocities via kinematic equations    
angVel=initAngVel+angAccel*impactT;
linVel=initLinVel+linAccel*impactT;
disp(linAccel);
end

    