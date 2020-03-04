%%A simulation to simulate a marble rolling down a track for MSE 222

clc; %%clears command window
        
%%constants
gravity = -9.806374046543; %%m/s^2
friction = 0.22;
mass = 0.02; %%kg

%%initial conditions
    %%(1,1) is the bottome left corner of the plate. 
position = [1,1,0];
    %%Linear values
linear_velocity = [1,1,0];
linear_acceleration = [1,1,0];
    %%angular values
angular_velocity = [0,0,0];
angular_acceleration = [0,0,0];
    %%forces
force = [0,0,0];

%%Map Initialization
map = zeros(600,600);
%%returns a list of all ramps in the map. Each ramp contains a list of start and end positions, and friction
[ramp_list] = ramp_list();

%%goes through each ramp, finds the line between points, and changes the
%%value of each part of the line to 1 in map.
for a = 1:length(ramp_list)
    m = (ramp_list(a).endY - ramp_list(a).startY)/(ramp_list(a).endX - ramp_list(a).startX); %%slope
    b = ramp_list(a).startY - m*ramp_list(a).startX;
    for i = ramp_list(a).startX : ramp_list(a).endX %%only check within bounds of the line
        for j = ramp_list(a).startY : ramp_list(a).endY %%only check within bounds of the line
            if (m*i + b) == j %%if the value of i satisfies the line equation then this point is on the line
                map(i,j) = 1;
            end
        end
    end
end

%%init the graph visualization
figure
set(gcf, 'Position',  [100, 100, 600, 600]) %sets graph window size and position

%% each second is 10 values for t. example: 20 seconds is t=200
for t = 0:100
    
    %%line below is update_tick which updates everything based on previous
    %%conditions.
    [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    
    %%print output to command window
    fprintf("t= " + t/10 + ", x= " + position(1) + ", y= " + position(2))
    fprintf(", xVelLin= " + linear_velocity(1) + ", yVelLin= " + linear_velocity(2))
    fprintf(", xAccelLin= " + linear_acceleration(1) + ", yAccelLin= " + linear_acceleration(2))
    fprintf(", xVelANG= " + angular_velocity(1)+ ", yVelANG= " + angular_velocity(2))
    fprintf(", xAccelANG= " + angular_acceleration(1) + ", yAccelANG = " + angular_acceleration(2))
    fprintf(", xForce = " + force(1) + ", yForce= " + force(2))
    fprintf(newline)
    
    %%draws the sphere
    draw(position)
    pause(0.01) %%done so we can actually see whats happening
end
