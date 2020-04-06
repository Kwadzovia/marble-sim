%%A simulation to simulate a marble rolling down a track for MSE 222

clc; %%clears command window
clear all;
close all;

%%================================constants================================
gravity = -9806.374046543; %%mm/s^2
gravity_m = -9.806374;
friction = 0.22;
mass = 0.002; %%kg
radiusmm = 5; %%mm
radius_m = radiusmm/1000;
impactF = 1; %%force of initial impact. N
impactT = 0.017; %%length of initial impact. s
marble_angle = 0;
coeff_restitution = 0.25;
%%=============================initial conditions=========================
%%(1,1) is the bottom left corner of the plate.
old_position = [0 0];
old_linear_velocity = [0 0];
position = [15,600];
map_position = position;
%%Linear values
linear_velocity = [0,0];
linear_acceleration = [0,gravity_m];
%%angular values
angular_velocity = 0;
angular_acceleration = 0;

%%inital impact
%[linear_acceleration, angular_acceleration, linear_velocity, angular_velocity] = ImpactOnAFlatSurface(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,impactT,gravity,mass,radius_m,impactF,friction,coeff_restitution);
interaction_num = 1;%%determines which object the marble is interacting with
col_occur_previous = false;

%%==============================Map Initialization========================
ramp_listvar = ramp_list();
%%=============================Misc Declarations==========================
col_occur = false;
animation_output = [];
current_time = 0;
stop_running = false;
fps = 50;
time = 0;
collided_ramp = 0;
impacted = 0;
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
%%set(gcf, 'Position', get(0, 'Screensize')); %Fullscreen
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
    
    while ~col_occur
        
        [linear_acceleration,angular_acceleration ] = freefall(linear_acceleration,angular_acceleration,gravity_m);
        [old_position, position, marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(mass,fps,position,marble_angle,gravity_m, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius_m,ramp_list,collided_ramp);
        [time] = update_frame(time,fps,time_handle,animation_output,radiusmm,marble_angle,position);
        
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
            
            templine = line([edge_old_pos(1) edge_pos(1)],[edge_old_pos(2) edge_pos(2)],'Color','r');
            delete(templine)
            
            [col_occur,collision_position] = detect_collision(edge_old_pos,edge_pos,current_surface(1,:),current_surface(2,:));
            if col_occur
                old_linear_velocity = linear_velocity;
                overshoot = edge_pos - collision_position;
                overshoot = 0 * norm(overshoot)/norm(old_linear_velocity);
                position = collision_position + overshoot - edge_offset;
                collided_ramp = j;
                marble = rectangle('Position', [position-[radiusmm radiusmm] radiusmm*2 radiusmm*2], 'Curvature', [1 1], 'EdgeColor', 'g');

                old_linear_velocity = [0 0];
                old_angular_velocity = [0 0];
                temp_surface = ramp_listvar{collided_ramp};
                
                
                if collided_ramp == 4; %Flat ramp where we use 1 N force
                    pause(1)
                    linear_velocity = [0 0];
                    linear_acceleration = [0 0];
                    [impacted,linear_acceleration, angular_acceleration, linear_velocity, angular_velocity] = ImpactOnAFlatSurface(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,impactT,gravity_m,mass,radius_m,impactF,friction,coeff_restitution);
                    break
                else
                
                    if impacted == 0
                        [impacted,linear_acceleration, angular_acceleration, linear_velocity, angular_velocity] = conservationCollision(linear_velocity,angular_velocity,linear_acceleration,angular_acceleration,radius_m,coeff_restitution,ramp_listvar,collided_ramp,position,collision_position);
                        col_occur = 0;
                    else
                        linear_velocity = [0 0];
                        linear_acceleration = [0 0];
                        impacted = 0;
                        break
                    end
                end
            	
            end
        end
    end
    %%output_to_cmd(time, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration);
    
    
    
    [old_position, position, marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(mass,fps,position,marble_angle,gravity_m, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius_m,ramp_list,collided_ramp);

    [time] = update_frame(time,fps,time_handle,animation_output,radiusmm,marble_angle,position);
    
    
    if temp_surface(2,1)-temp_surface(1,1) < 0
        if position(1) < temp_surface(2,1) && linear_velocity(1) < 0
            col_occur = false;
        end
    else
        if position(1) > temp_surface(2,1) && linear_velocity(1) > 0
            col_occur = false;
        end
    end
    
    %%Impact physics can happen after a collision detected from freefall
    %%After maybe 1 impact go back to rolling without slipping
    %%Physics for any loops will also have to be special
    
end

function output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration)
fprintf("t= " + t + ", x= " + position(1) + ", y= " + position(2))
fprintf(", xVelLin= " + linear_velocity(1) + ", yVelLin= " + linear_velocity(2))
fprintf(", xAccelLin= " + linear_acceleration(1) + ", yAccelLin= " + linear_acceleration(2))
fprintf(", VelANG= " + angular_velocity)
fprintf(", AccelANG= " + angular_acceleration)
fprintf(newline)
end


