%%A simulation to simulate a marble rolling down a track for MSE 222

clc; %%clears command window
        
%%constants
gravity = -9.806374046543; %%m/s^2
friction = 0.22;
mass = 0.02; %%kg

%%initial conditions
    %%(0,0) is the bottome left corner of the plate. 
position = [0,0.6,0];
    %%Linear values
linear_velocity = [1,1,0];
linear_acceleration = [1,1,0];
    %%angular values
angular_velocity = [0,0,0];
angular_acceleration = [0,0,0];
    %%forces
force = [0,0,0];
figure
set(gcf, 'Position',  [100, 100, 600, 600])
%% each second is 10 values for t. example: 20 seconds is t=200
for t = 0:400 %%400 chosen because if we get to this time something has gone horribly wrong
    
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
    draw(position)
    pause(0.01)
end
