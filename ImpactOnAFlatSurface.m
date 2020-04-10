%impact on a flat surface. inputs are linear & angular velocities, impact time, gravity, mass, radius, impact force
%%returns new linear & angular accelerations

function [impacted,linAccel,angAccel,linVel,angVel] = ImpactOnAFlatSurface(linVel,angVel,linAccel,angAccel,impactT,gravity,mass,radius,impactF,friction,restitution)
MOI=(2/5)*mass*radius^2; %%moment of inertia





pend_mass = 0.075;
marble_mass = mass;
diameter = radius*2;
string_length = 0.03;
collision_theta = degtorad(25);
abs_gravity = abs(gravity);

max_dist = diameter/2+string_length;

%%Full Formulation
V1 = -mass*abs_gravity*max_dist;
omega1 = sqrt(abs_gravity*(1-cos(collision_theta))/max_dist);
omega2 = (restitution*V1 - 2*pend_mass*max_dist^2*omega1/(marble_mass*(string_length+radius)))...
          /...
         (max_dist*( 1   +   (2*pend_mass*max_dist)/(marble_mass*(string_length+radius))  )  );

linVel(1) = 2*pend_mass*max_dist^2*(omega1+omega2)/(marble_mass*(string_length+radius));
linVel(1) = linVel(1) *1000;













angVel = -linVel(1)/(radius*1000);

angAccel = -5/2*friction*gravity/(radius*1000);
linAccel(1) = -angAccel*radius;
impacted = 0;



end

