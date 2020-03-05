%%takes the map and outputs 2 arrays of all solid locations in the map for
%%graphing
function [solidX solidY] = make_solid(map)
    solid_index = 1;
    for i = 1:600
        for j = 1:600
            if map(i,j) == 1
              solidX(solid_index) = i;
              solidY(solid_index) = j;
             solid_index = solid_index + 1;
            end
        end
    end
end