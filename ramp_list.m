%%returns a list of all ramps in the map. Each ramp contains a list of
%%start and end positions, and friction
function output_list = ramp_list()
    
    output_list = {[10 500; 500 500],...
         [590 480; 20 460],...
         [10 440; 580 400],...
         [10 300; 580 280],...
         [590 260; 20 220],...
         [10 200; 580 150],...
         [590 100; 10 50],...
         [10 30; 690 1]};
     
    %%ramp 1
    ramp(1).startX = 10;
    ramp(1).startY = 500;
    ramp(1).endX = 500;
    ramp(1).endY = 500;
    ramp(1).friction = 0;
    
    %%ramp2
    ramp(2).startX = 590;
    ramp(2).startY = 480;
    ramp(2).endX = 20;
    ramp(2).endY = 460;
    ramp(2).friction = 0;
    
    %%ramp 3
    ramp(3).startX = 10;
    ramp(3).startY = 440;
    ramp(3).endX = 580;
    ramp(3).endY = 400;
    ramp(3).friction = 0;
    
    %%ramp 4
    ramp(4).startX = 10;
    ramp(4).startY = 300;
    ramp(4).endX = 580;
    ramp(4).endY = 280;
    ramp(4).friction = 0;
    
    %%ramp 5
    ramp(5).startX = 590;
    ramp(5).startY = 260;
    ramp(5).endX = 20;
    ramp(5).endY = 220;
    ramp(5).friction = 0;
    
    %%ramp 6
    ramp(6).startX = 10;
    ramp(6).startY = 200;
    ramp(6).endX = 580;
    ramp(6).endY = 150;
    ramp(6).friction = 0;
    
    %%ramp 7
    ramp(7).startX = 590;
    ramp(7).startY = 100;
    ramp(7).endX = 10;
    ramp(7).endY = 50;
    ramp(7).friction = 0;
    
    %%ramp 8
    ramp(8).startX = 10;
    ramp(8).startY = 30;
    ramp(8).endX = 690;
    ramp(8).endY = 1;
    ramp(8).friction = 0;
    
%     for i = 1:length(ramp)
%         list(i) = ramp(i);
%     end
end
