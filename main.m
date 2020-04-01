%%A simulation to simulate a marble rolling down a track for MSE 222

clc; %%clears command window
clear all;
close all;

%%================================constants================================
gravity = -980.6374046543; %%cm/s^2
friction = 0.22;
mass = 0.02; %%kg
radiusmm = 5; %%mm
radius_m = radiusmm/1000;
impactF = 1; %%force of initial impact. N
impactT = 0.1; %%length of initial impact. s

%%=============================initial conditions=========================
    %%(1,1) is the bottom left corner of the plate.
position = [110,550,0];
map_position = position;
    %%Linear values
linear_velocity = [50,0,0];
linear_acceleration = [0,gravity,0];
    %%angular values
angular_velocity = [0,0,0];
angular_acceleration = [0,0,0];

%%inital impact
%%[linear_acceleration,angular_acceleration,linear_velocity,angular_velocity] = ImpactOnAFlatSurface(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,impactT,gravity,mass,radius_m,impactF,friction);

interaction_num = 1;%%determines which object the marble is interacting with
col_occur_previous = false;

%%==============================Map Initialization========================
%map = zeros(600,600);
[ramp_listvar] = ramp_list();
%map = map_ramp(ramp_listvar,map);
%[solidX, solidY] = make_solid(map);



%%=============================Misc Declarations==========================
col_occur = false;



anim_window = figure;
a = [0:0.1:2*pi];
circle_x = cos(a);
circle_y = sin(a);
grid on
axis('square')
xlim([0 600]) %sets axis at 600
ylim([0 600])
hold on
time_handle = text(450,550,strcat(num2str(0,'%.2f')," "," seconds"));
marble = patch(position(1)+radiusmm*circle_x , position(2)+radiusmm*circle_y,'b');

intervals = 80;
thickness = 5;

animation_output = [];
timestep = 0.01;

%%Plot ramps
for i = 1:1:length(ramp_listvar)
ramp_list_x = linspace(ramp_listvar(i).startX,ramp_listvar(i).endX,intervals);
ramp_list_y = linspace(ramp_listvar(i).startY,ramp_listvar(i).endY,intervals);

    for j=1:1:intervals
        patch(ramp_list_x(j)+thickness*circle_x,ramp_list_y(j)+thickness*circle_y,'g')
    end

end


%%=================================Main For===============================
for t = 0:timestep:20
    
    %output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    
    %%updates based on previous conditions
    [position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(timestep,position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius_m);
    animation_output = update_frame(t,position,radiusmm,circle_x,circle_y,marble,anim_window,time_handle,animation_output);
    %     map_position(1) = int16(position(1));
%     map_position(2) = int16(position(2));
%     
    %%====================checks if there is a collision==================
    col_occur = false;
    collision_position = [];
    [out_of_bounds,collision_position,col_occur] = detect_collision(position, ramp_listvar, radiusmm, intervals, thickness);
    
    %%if out of bounds we record the animation and kill the program
    if (out_of_bounds)
        break %%exits main for loop
    end
    
    angular_acceleration = [0,0,0];
    %%==========================collision handling========================
    if(col_occur) %%handles the collision if there was one
        linear_velocity(2) = 0;
        col_occur_previous = true;
        %[angular_acceleration, linear_acceleration] = ramp_physics(mass, gravity, radius_m, ramp_listvar(interaction_num), angular_acceleration, linear_acceleration);
%     else %%otherwise keep gravitational acceleration going
%         col_occur_previous = false;
%         linear_acceleration = [0,(gravity/mass),0];
    else
        continue
    end
    %%append individual animation frame to total video
    
end

%%===========================animation=====================================
%%Uncomment below to play a saved animation once (at 20fps)

% replay_window = figure;
% axis('square')
% xlim([0 600]) %sets axis at 600
% ylim([0 600])
% movie(replay_window,animation_output,1,20)  


function output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration)
    fprintf("t= " + t/10 + ", x= " + position(1) + ", y= " + position(2))
    fprintf(", xVelLin= " + linear_velocity(1) + ", yVelLin= " + linear_velocity(2))
    fprintf(", xAccelLin= " + linear_acceleration(1) + ", yAccelLin= " + linear_acceleration(2))
    fprintf(", VelANG= " + angular_velocity(3))
    fprintf(", AccelANG= " + angular_acceleration(3))
    fprintf(newline)
end
