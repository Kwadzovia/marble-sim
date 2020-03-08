%%A simulation to simulate a marble rolling down a track for MSE 222

clc; %%clears command window
        
%%================================constants================================
gravity = -9.806374046543; %%m/s^2
friction = 0.22;
mass = 0.02; %%kg
radius = 5; %%mm

%%=============================initial conditions=========================
    %%(1,1) is the bottome left corner of the plate. 
position = [110,550,0];
    %%Linear values
linear_velocity = [0,0,0];
linear_acceleration = [3,-5,0];
    %%angular values
angular_velocity = [0,0,0];
angular_acceleration = [0,0,0];
    %%forces
force = [0,0,0];

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
%% each second is 10 values for t. example: 20 seconds is t=200
for t = 0:400
    
    %%updates based on previous conditions
    [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    
    out_of_bounds = detect_collision(position, map, radius);
    if (out_of_bounds)
        return %%kills the program if the marble leaves
    end
    %%draws the sphere
    draw(position, radius)
    
    %%uncomment to output to command window
    %%output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, force)
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
