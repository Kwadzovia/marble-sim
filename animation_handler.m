function animationOutput = animation_handler(positionHistory,radius,initialSecond,fps,solidX,solidY)
%%Runs the simulation then plays from time given
%%Lets you store runs in the output

figure('Name','Saving Animation...','NumberTitle','off')
set(gcf, 'Position',  [1, 1, 600, 600]) %sets graph window size and position

position = [0,0,0];

%%finds where to start if gave a different starting point
if initialSecond ~= 0
    startingIndex = 100*initialSecond;
else
    startingIndex = 1;
end
    animationOutput = [];
    for i=startingIndex:1:length(positionHistory)
       if (positionHistory(i,1) == 0 && positionHistory(i,2) == 0)
           break
       end
       %Assuming 100 ticks per second
       if mod(i,100/fps) == 0
           clf
           hold on
           xlim([1, 600])
           ylim([1, 600])

           scatter(solidX,solidY) %Draw walls and Ramps
           
           position(1) = positionHistory(i,1);
           position(2) = positionHistory(i,2);
           draw(position,radius)
           
           %scatter(data(i,1),data(i,2))strcat(string(50.0/100.0)," "," seconds")
           text(450,500,strcat(num2str(i/100,'%.2f')," "," seconds"))
           f = getframe;
           animationOutput = [animationOutput f];
       end
    end
    close
end