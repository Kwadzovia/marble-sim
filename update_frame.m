function [time] = update_frame(time,fps,time_handle,frame_container,radius,marble_angle,position)
%update Time
set(time_handle,'String',strcat(num2str(time,'%.2f')," "," seconds"))

offset = radius * [cos(marble_angle) sin(marble_angle)];
p1 = position + offset;
p2 = position - offset;
halfline = line([p1(1) p2(1)], [p1(2) p2(2)], 'Color', 'k');
scattertemp = scatter(p1(1),p1(2),18,'filled');
marble = rectangle('Position', [position-[radius radius] radius*2 radius*2], 'Curvature', [1 1]);


time = time + 1/fps;





drawnow
wait_time = 1/fps - toc;
if wait_time > 0, pause(wait_time); end
tic

delete(marble)
delete(halfline)
delete(scattertemp)
%%Save Frame
%f = getframe(figure_handle);
%frame_container = [frame_container f];

end