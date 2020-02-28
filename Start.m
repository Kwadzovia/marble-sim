%%A simulation to simulate a marble rolling down a track for MSE 222

%%Commands for this program:
%%printToCMD(t,xpos,ypos,xvelocity,yvelocity,xacceleration,yacceleration)
%%  prints data to command window


xpos = 0;
ypos = 0;
xvelocity = 0;
yvelocity = 0;
xacceleration = 0;
yacceleration = 0;


%% each second is 10 values for t. example: 20 seconds is t=200
for t = 0:400 %%400 chosen because if we get to this time something has gone horribly wrong

    printToCMD(t,xpos,ypos,xvelocity,yvelocity,xacceleration,yacceleration)
end