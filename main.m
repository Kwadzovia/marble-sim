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
linear_acceleration = [30,gravity/mass,0];
    %%angular values
angular_velocity = [0,0,0];
angular_acceleration = [0,0,0];
    %%forces
force = [0,0,0];

%%=============================init graph visualization====================

%%ramps

    ramp(1).startX = 100;
    ramp(1).endX = 300;
    ramp(1).equation = symfun(-(1)*x + 600, x)
    ramp(1).slope = diff(ramp(1).equation)
    
    ramp(2).startX = 400;
    ramp(2).endX = 150;
    ramp(2).equation = symfun(x - 100,x)
    ramp(2).slope = diff(ramp(2).equation)

    
    for i = 1:2
        x(i) = linspace(ramp(i).startX, ramp(i).endX, ramp(i).startX - ramp(i).endX )
        y(i) = ramp(i).equation(x(i))
        plot (x(i),y(i)]
        hold on 
    end
    
    
%%=================================Main For===============================
%% each second is 100 values for t. example: 20 seconds is t=2000
for t = 0:4000
    
    %%updates based on previous conditions
    [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    
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
