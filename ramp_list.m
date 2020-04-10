%%returns a list of all ramps in the map. Each ramp contains a list of
%%start and end positions, and friction
function output_list = ramp_list()

%%First four are walls, starting then end points seperated by semicolon
%%For simulation, the final point has to be the one where you expect the
%%marble to pass last

output_list = {[0 0; 0 600],...
    [0 0; 600 0],...
    [600 0; 600 600],...
    [0 590; 570 590],...
    [600 425; 45 300],...
    [0 265; 300 260],... 
    [530 240; 240 220],...
    [120 210; 400 190],...
    [600 170;320 160],...
    [325 125; 60 120],...
    [8 123.8; 5 95],...
    [5 95; 245 70],...
    [180 25; 600 0],...
    [5 460; 580 455],...
    [600 570; 500 540]...
    [260 100; 260 60]};

end
