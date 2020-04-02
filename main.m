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
coeff_restitution = 0.1;
%%=============================initial conditions=========================
%%(1,1) is the bottom left corner of the plate.
old_position = [0 0];
old_linear_velocity = [0 0];
position = [30,radiusmm+550];
map_position = position;
%%Linear values
linear_velocity = [0,0];
linear_acceleration = [0,gravity];
%%angular values
angular_velocity = 0;
angular_acceleration = 0;

%%inital impact
[linear_acceleration, angular_acceleration, linear_velocity, angular_velocity] = ImpactOnAFlatSurface(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,impactT,gravity,mass,radius_m,impactF,friction,coeff_restitution);
interaction_num = 1;%%determines which object the marble is interacting with
col_occur_previous = false;

%%==============================Map Initialization========================
ramp_listvar = ramp_list();
%%=============================Misc Declarations==========================
col_occur = false;
animation_output = [];
current_time = 0;
stop_running = false;
fps = 20;
%%=============================Window Setup===============================
anim_window = figure;
a = [0:0.1:2*pi];
circle_x = cos(a);
circle_y = sin(a);
grid on
axis('square')
xlim([0 600]) %sets axis at 600
ylim([0 600])
hold on
set(gcf, 'Position', get(0, 'Screensize')); %Fullscreen
time_handle = text(450,550,strcat(num2str(0,'%.2f')," "," seconds"));


%%Plot ramps
for i = 1:1:length(ramp_listvar)
    current_ramp = ramp_listvar{i};
    line([current_ramp(:,1)],[current_ramp(:,2)])
end


%%Used in https://www.mathworks.com/matlabcentral/fileexchange/27900-ball-bounce-physics-with-spin?focused=5155060&tab=function
%%Stop Button for Window
h_stop = uicontrol('Position',[15 340 80 30],'Style','pushbutton','String','Stop','Callback',...
    'stop_running=~stop_running;if stop_running,set(h_stop,''String'',''Restart'');,else,set(h_stop,''String'',''Stop'');main;,end');

%Start Timer for fps
tic 
%%=================================Main For===============================
while ~stop_running %%Runs forever, kinda buggy if you don't press stop button
    
    %output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    marble = rectangle('Position', [position-[radiusmm radiusmm] radiusmm*2 radiusmm*2], 'Curvature', [1 1]);
    offset = radiusmm * [cos(marble_angle) sin(marble_angle)];
    p1 = position + offset;
    p2 = position - offset;
    halfline = line([p1(1) p2(1)], [p1(2) p2(2)], 'Color', 'k');
    %%updates based on previous conditions
    current_time = current_time + 1/fps;

    [old_position, position, marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(fps,position,marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radiusmm);
    animation_output = update_frame(current_time,position,radiusmm,circle_x,circle_y,anim_window,time_handle,animation_output);
    
    if abs((linear_velocity(2)-old_linear_velocity(2))*100/old_linear_velocity(2)) < 5 && col_occur_previous
        %Rolling??
        is_rolling = true;
    else
        is_rolling = false;
    end
    old_linear_velocity = linear_velocity;

    drawnow
    wait_time = 1/fps - toc;
    if wait_time > 0, pause(wait_time); end
    tic
    delete(marble)
    delete(halfline)

    %%====================checks if there is a collision==================
    col_occur = false;
    collision_position = [];
    out_of_bounds = false;
    
    for j = 1 : length(ramp_listvar)
        %%Collision Tests
        %%Find normal vector
        current_surface = ramp_listvar{j};
        normal = [current_surface(2,2)-current_surface(1,2) current_surface(1,1)-current_surface(2,1)];
        normal = normal/norm(normal);
        vel_dir = linear_velocity / norm(linear_velocity);
        if normal * vel_dir' < 0, normal = normal*-1; end
        
        edge_offset = normal*radiusmm;
        edge_old_pos = old_position + edge_offset;
        edge_pos = position + edge_offset;
        

        [col_occur,collision_position] = detect_collision(edge_old_pos,edge_pos,current_surface(1,:),current_surface(2,:));
        
        if col_occur
            %%Readjustment based on collision physics
            old_linear_velocity = linear_velocity;
            overshoot = edge_pos - collision_position;
            
            %%These lines Show where marble would go if there was no collision
%              templine = line([edge_old_pos(1) edge_pos(1)],[edge_old_pos(2) edge_pos(2)]);
%              marble = rectangle('Position', [position-[radiusmm radiusmm] radiusmm*2 radiusmm*2], 'Curvature', [1 1]);
            
            
            
            %angular_acceleration = [0,0];
            %%==========================Collision Handling========================
            %%handles the collision if there was one
            %%Treat as if collision at collision_position when rolling
            col_occur_previous = true;
            
            %% Impact Physics
                if ~is_rolling
                    old_angular_velocity = angular_velocity;
                    old_linear_velocity = linear_velocity;
                    angular_velocity = 5*(linear_velocity(1)-2/5*old_angular_velocity*radius_m)/(7*radius_m);
                    linear_velocity(2) = -coeff_restitution*linear_velocity(2);

                    linear_velocity(1) = 5/7*(linear_velocity(1)-2/5*old_angular_velocity*radius_m);
                    angular_acceleration=linear_acceleration(1)/radius_m;
                else
                %% Rolling Physics
                    %[angular_acceleration, linear_acceleration] = ramp_physics(mass, gravity, radius_m, ramp,angular_acceleration, linear_acceleration)
                    
                    %Replace this with actual rolling equations
                    angular_velocity = 5*(linear_velocity(1)-2/5*old_angular_velocity*radius_m)/(7*radius_m);
                    linear_velocity(2) = -coeff_restitution*linear_velocity(2);
                end
            
            
            
            %%Marble Readjusted to account for collision
            overshoot = linear_velocity * norm(overshoot)/norm(old_linear_velocity);
            position = collision_position + overshoot - edge_offset;
%             marble = rectangle('Position', [position-[radiusmm radiusmm] radiusmm*2 radiusmm*2], 'Curvature', [1 1],'EdgeColor','g'); %Where the marble is after readjustment
        end
    end
end

%%===========================animation=====================================
%%No Idea if this works anymore
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
