function [frame_container] = update_frame(time,position,radius,circle_x,circle_y,figure_handle,time_handle,frame_container)    
   %update Time
   set(time_handle,'String',strcat(num2str(time,'%.2f')," "," seconds"))
   
   %%Save Frame   
   f = getframe(figure_handle);
   frame_container = [frame_container f];
   
end