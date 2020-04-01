function [frame_container] = update_frame(time,position,radius,circle_x,circle_y,marble_handle,figure_handle,time_handle,frame_container)    
   %%Plot ball
   set(marble_handle,'XData',position(1)+radius*circle_x,'YData',position(2)+radius*circle_y)
   

   
   %update Time
   set(time_handle,'String',strcat(num2str(time,'%.2f')," "," seconds"))
   
   %%Save Frame   
   f = getframe(figure_handle);
   frame_container = [frame_container f];
   
end