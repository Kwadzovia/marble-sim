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
wheel_past = 0;

%%=============================Stats Setup===============================
time_axis = [];
position_stats_x = [];
position_stats_y = [];

velocity_stats_x = [];
velocity_stats_y = [];

acceleration_stats_x = [];
acceleration_stats_y = [];

angular_velocity_stats = [];
angular_acceleration_stats = [];
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
%%Plot wheel
wheel_image = rectangle('Position',[130 330 25  25],'Curvature',[0.5,1],'EdgeColor','r','FaceColor',[0.5 0.1 .1]);

%%all this junk is to draw the circle
circ_rad = 990;
circ_centre = [260 1500];
thetacirc = linspace(0,2*pi,1000);
circx = circ_rad*cos(thetacirc)+circ_centre(1);
circy = circ_rad*sin(thetacirc)+circ_centre(2);
for i = 1:length(circx)
    if circx(i) < 40
        circx(i) = 40;
        circy(i) = 510;
    end
end
for i = 1:length(circy)
    if circy(i) > 590
        circy(i) = 510;
    end
end
plot(circx,circy); %%end of trash to draw circle


%%Used in https://www.mathworks.com/matlabcentral/fileexchange/27900-ball-bounce-physics-with-spin?focused=5155060&tab=function
%%Stop Button for Window
h_stop = uicontrol('Position',[15 340 80 30],'Style','pushbutton','String','Stop','Callback',...
    'stop_running=~stop_running;if stop_running,set(h_stop,''String'',''Restart'');,else,set(h_stop,''String'',''Stop'');main;,end');

%Start Timer for fps
tic
%%=================================Main For===============================
while ~stop_running %%Runs forever, kinda buggy if you don't press stop button
    
    while ~col_occur
            
            %%End of simulation
            if position(1) > 600 && position(2) < 0
                stop_running = true
                break
            end
        
        [linear_acceleration,angular_acceleration ] = freefall(linear_acceleration,angular_acceleration,gravity_m);
        [old_position, position, marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(mass,fps,position,marble_angle,gravity_m, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius_m,ramp_list,collided_ramp);
        [time] = update_frame(time,fps,time_handle,animation_output,radiusmm,marble_angle,position);
        
        %%Stats Collection

            time_axis = [time_axis time];
            position_stats_x = [position_stats_x position(1)];
            position_stats_y = [position_stats_y position(2)];

            velocity_stats_x = [velocity_stats_x linear_velocity(1)];
            velocity_stats_y = [velocity_stats_y linear_velocity(2)];

            acceleration_stats_x = [acceleration_stats_x linear_acceleration(1)];
            acceleration_stats_y = [acceleration_stats_y linear_acceleration(2)];
            
            
            if ~isempty(angular_velocity)
                angular_velocity_stats = [angular_velocity_stats angular_velocity];
            else
                if col_occur
                    angular_velocity_stats = [angular_velocity_stats 1000*norm(angular_velocity_stats)/radius_m];
                else
                    angular_velocity_stats = [angular_velocity_stats 0];
                end
            end
            
            if ~isempty(angular_acceleration)
                angular_acceleration_stats = [angular_acceleration_stats angular_acceleration];
            else
                if col_occur
                    angular_acceleration_stats = [angular_acceleration_stats 1000*norm(linear_acceleration)/radius_m];
                else
                    angular_acceleration_stats = [angular_acceleration_stats 0];
                end
            end

        
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
    
    if collided_ramp == 5 && ~wheel_past
        %%141,150
       if position(1) < 145 && linear_velocity(1) < 0
          linear_velocity = -coeff_restitution*linear_velocity;
          angular_velocity = 0;
          wheel_past = 1;
          
          set(wheel_image,'EdgeColor','g','FaceColor',[0.1 0.5 .1])
       end
    end
        
    
    [old_position, position, marble_angle, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration] = update_tick(mass,fps,position,marble_angle,gravity_m, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration, col_occur, radius_m,ramp_list,collided_ramp);

    [time] = update_frame(time,fps,time_handle,animation_output,radiusmm,marble_angle,position);
    
    %%Stats Collection

        time_axis = [time_axis time];
        position_stats_x = [position_stats_x position(1)];
        position_stats_y = [position_stats_y position(2)];

        velocity_stats_x = [velocity_stats_x linear_velocity(1)];
        velocity_stats_y = [velocity_stats_y linear_velocity(2)];

        acceleration_stats_x = [acceleration_stats_x linear_acceleration(1)];
        acceleration_stats_y = [acceleration_stats_y linear_acceleration(2)];

        if ~isempty(angular_velocity)
            angular_velocity_stats = [angular_velocity_stats angular_velocity];
        else
            if col_occur
                angular_velocity_stats = [angular_velocity_stats 1000*norm(angular_velocity_stats)/radius_m];
            else
                angular_velocity_stats = [angular_velocity_stats 0];
            end
        end

        if ~isempty(angular_acceleration)
            angular_acceleration_stats = [angular_acceleration_stats angular_acceleration];
        else
            if col_occur
                angular_acceleration_stats = [angular_acceleration_stats 1000*norm(linear_acceleration)/radius_m];
            else
                angular_acceleration_stats = [angular_acceleration_stats 0];
            end
        end

    if collided_ramp == 15
        if position(1) < 42 && linear_velocity(1) < 0 %% Harcoded round ramp ending
            col_occur = false;
        end
    else
        if temp_surface(2,1)-temp_surface(1,1) < 0
            if position(1) < temp_surface(2,1) && linear_velocity(1) < 0
                col_occur = false;
            end
        else
            if position(1) > temp_surface(2,1) && linear_velocity(1) > 0
                col_occur = false;
            end
        end
    end
    
    if position(1) > 600 && position(2) < 0
        stop_running = true
    end
    
end
figure
subplot(2,1,1)
plot(time_axis,position_stats_x)
title('X Position vs time')
xlabel('time (s)') 
ylabel('position (mm)')

subplot(2,1,2)
plot(time_axis,position_stats_y)
title('Y Position vs time')
xlabel('time (s)') 
ylabel('position (mm)')

figure
subplot(2,1,1)
plot(time_axis,velocity_stats_x)
title('X Velocity vs time')
xlabel('time (s)')
ylabel('velocity (mm/s)')

subplot(2,1,2)
plot(time_axis,velocity_stats_y)
title('Y Velocity vs time')
xlabel('time (s)')
ylabel('velocity (mm/s)')

figure
subplot(2,1,1)
plot(time_axis,acceleration_stats_x)
title('X Acceleration vs time')
xlabel('time (s)') 
ylabel('acceleration (mm/s^2)')

subplot(2,1,2)
plot(time_axis,acceleration_stats_y)
title('Y Acceleration vs time')
xlabel('time (s)') 
ylabel('acceleration (mm/s^2)')

figure
subplot(2,1,1)
plot(time_axis,angular_velocity_stats)
title('Angular Velocity vs time')
xlabel('time (s)') 
ylabel('angular velocity (rad/s)')

subplot(2,1,2)
plot(time_axis,angular_acceleration_stats)
title('Angular Acceleration vs time')
xlabel('time (s)') 
ylabel('angular acceleration (rad/s^2)')

function output_to_cmd(t, position, linear_velocity, linear_acceleration, angular_velocity, angular_acceleration)
fprintf("t= " + t + ", x= " + position(1) + ", y= " + position(2))
fprintf(", xVelLin= " + linear_velocity(1) + ", yVelLin= " + linear_velocity(2))
fprintf(", xAccelLin= " + linear_acceleration(1) + ", yAccelLin= " + linear_acceleration(2))
fprintf(", VelANG= " + angular_velocity)
fprintf(", AccelANG= " + angular_acceleration)
fprintf(newline)
end


