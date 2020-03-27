%%A simulation to simulate a marble rolling down a track for MSE 222

clc; %%clears command window
        
%%================================constants================================
gravity = -9.806374046543; %%m/s^2
friction = 0.22;
mass = 0.02; %%kg
radius = 5; %%mm
impactF = 1 %%force of initial impact. N
impactT = 0.1; %%length of initial impact. s

%%=============================initial conditions=========================
    %%(1,1) is the bottome left corner of the plate. 
position = [110,550,0];
    %%Linear values
linear_velocity = [0,0,0];
linear_acceleration = [0,gravity/mass,0];
    %%angular values
angular_velocity = [0,0,0];
angular_acceleration = [0,0,0];

%%function assumes we are traveling to the right
[linear_acceleration,angular_acceleration,linear_velocity,angular_velocity] = ImpactOnAFlatSurface(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,impactT,gravity,mass,radius,impactF,friction);



%%==============================Map Initialization========================
map = zeros(600,600);
[ramp_list] = ramp_list();
map = map_ramp(ramp_list,map);
[solidX, solidY] = make_solid(map);


%%=============================init graph visualization====================
figure
set(gcf, 'Position',  [1, 1, 600, 600]) %sets graph window size and position
scatter(solidX,solidY) %%needed to be scatter so it doesn't try connecting different objects
hold on


%%=================================Main For===============================
%% each second is 100 values for t. example: 20 seconds is t=2000
for t = 0:4000
    
    %%updates based on previous conditions
    [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    
    
    %%====================checks if there is a collision==================
    colX = 0;
    colY = 0;
    col_occur = false;
    
    [out_of_bounds,colX,colY,col_occur] = detect_collision(position, map, radius);
    
    if (out_of_bounds)
        return %%kills the program if the marble leaves
    end
    
    
    %%==========================collision handling========================
    if(col_occur) %%handles the collision if there was one
        [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = collision_handle(colX, colY, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    else %%otherwise keep gravitational acceleration going
        linear_acceleration(2) = gravity/mass;
    end
    
    
    %%============================display=================================
    if mod(t, 5) == 0%%draws the sphere every 5 ticks
        draw(position, radius)
    end
    
    %%uncomment to output to command window
    %%output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, force)
    
    pause(0.0001) %%done so we can actually see whats happening
end

function output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, force)
    fprintf("t= " + t/10 + ", x= " + position(1) + ", y= " + position(2))
    fprintf(", xVelLin= " + linear_velocity(1) + ", yVelLin= " + linear_velocity(2))
    fprintf(", xAccelLin= " + linear_acceleration(1) + ", yAccelLin= " + linear_acceleration(2))
    fprintf(", xVelANG= " + angular_velocity(1)+ ", yVelANG= " + angular_velocity(2))
    fprintf(", xAccelANG= " + angular_acceleration(1) + ", yAccelANG = " + angular_acceleration(2))
    fprintf(", xForce = " + force(1) + ", yForce= " + force(2))
    fprintf(newline)
end
