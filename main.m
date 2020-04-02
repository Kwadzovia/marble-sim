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
marble_angle = 0;
coeff_restitution = 0.5;
%%=============================initial conditions=========================
%%(1,1) is the bottom left corner of the plate.
old_position = [];
position = [550,530];
map_position = position;
%%Linear values
linear_velocity = [150,0];
linear_acceleration = [0,gravity];
%%angular values
angular_velocity = 0;
angular_acceleration = 0;

%%inital impact
%%[linear_acceleration,angular_acceleration,linear_velocity,angular_velocity] = ImpactOnAFlatSurface(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,impactT,gravity,mass,radius_m,impactF,friction);

interaction_num = 1;%%determines which object the marble is interacting with
col_occur_previous = false;

%%==============================Map Initialization========================
%map = zeros(600,600);
ramp_listvar = ramp_list();
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


intervals = 100;
thickness = 5;

animation_output = [];
timestep = 0.01;

%%Plot ramps
for i = 1:1:length(ramp_listvar)
    current_ramp = ramp_listvar{i};
    line([current_ramp(:,1)],[current_ramp(:,2)])
end

fps = 20;
tic
current_time = 0;
stop_running = false;
%%=================================Main For===============================
while ~stop_running %%Runs forever, kinda buggy but can be fixed later
    
    %output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    marble = rectangle('Position', [position-[radiusmm radiusmm] radiusmm*2 radiusmm*2], 'Curvature', [1 1]);
    offset = radiusmm * [cos(marble_angle) sin(marble_angle)];
    p1 = position + offset;
    p2 = position - offset;
    halfline = line([p1(1) p2(1)], [p1(2) p2(2)], 'Color', 'k');
    %%updates based on previous conditions
    current_time = current_time + 1/fps;
    [old_position, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(fps,position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius_m);
    animation_output = update_frame(current_time,position,radiusmm,circle_x,circle_y,anim_window,time_handle,animation_output);
    
    drawnow
    wait_time = 1/fps - toc;
    if wait_time > 0, pause(wait_time); end
    tic
    delete(marble)
    delete(halfline)
    %     map_position(1) = int16(position(1));
    %     map_position(2) = int16(position(2));
    %
    %%====================checks if there is a collision==================
    col_occur = false;
    collision_position = [];
    out_of_bounds = false;
    
    for j = 1 : length(ramp_listvar)
        %%True Collision Tests
        %%Find normal vector
        current_surface = ramp_listvar{j};
        normal = [current_surface(2,2)-current_surface(1,2) current_surface(1,1)-current_surface(2,1)];
        normal = normal/norm(normal);
        vel_dir = linear_velocity / norm(linear_velocity);
        if normal * vel_dir' < 0, normal = normal*-1; end
        
        edge_offset = normal*radiusmm;
        edge_old_pos = old_position + edge_offset;
        edge_pos = position + edge_offset;
        
        %templine = line([old_position(1) position(1)],[old_position(2) position(2)]);
        %templine = line([edge_old_pos(1) edge_pos(1)],[edge_old_pos(2) edge_pos(2)]);
        %delete(templine)
        [col_occur,collision_position] = detect_collision(old_position,position,current_surface(1,:),current_surface(2,:));
        
        if col_occur
            %%Readjustment based on collision physics
            old_linear_velocity = linear_velocity;
            overshoot = edge_pos - collision_position;
            
            %Shows where marble would go if there was no collision
            templine = line([edge_old_pos(1) edge_pos(1)],[edge_old_pos(2) edge_pos(2)]);
            marble = rectangle('Position', [position-[radiusmm radiusmm] radiusmm*2 radiusmm*2], 'Curvature', [1 1]);
            
            
            
            %%Physics Calculations
            [linear_acceleration, angular_acceleration, linear_velocity, angular_velocity] = ImpactOnAFlatSurface(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,impactT,gravity,mass,radius_m,impactF,friction,coeff_restitution);
            
            
            %angular_acceleration = [0,0];
            %%==========================Collision Physics========================
            %%handles the collision if there was one
            %%Treat as if collision at collision_position
            col_occur_previous = true;
            %[angular_acceleration, linear_acceleration] = ramp_physics(mass, gravity, radius_m, ramp_listvar(interaction_num), angular_acceleration, linear_acceleration);
            %     else %%otherwise keep gravitational acceleration going
            %         col_occur_previous = false;
            %         linear_acceleration = [0,(gravity/mass),0];
            
            %%Marble Readjusted to account for collision
            overshoot = linear_velocity * norm(overshoot)/norm(old_linear_velocity);
            position = collision_position + overshoot - edge_offset;
            marble = rectangle('Position', [position-[radiusmm radiusmm] radiusmm*2 radiusmm*2], 'Curvature', [1 1],'EdgeColor','g'); %Where the marble is after readjustment
        else
            col_occur_previous = true;
        end
        %delete(templine)
    end
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
