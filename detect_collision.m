function [col_occured,intersection_pos] = detect_collision(marble_old_pos, marble_pos, edge_start, edge_end)
%%Collision happened if displacement line of marble crosses the edge line

col_occured = false;
intersection_pos = [];

marble_vector = marble_pos - marble_old_pos;

edge_pos = edge_end - edge_start;



%%Point 1 Orientation Vectors
dir_1 = marble_old_pos - edge_end;
%dir_1 = dir_1 + edge_end;

%linetemp3 = line([edge_end(1) dir_1(1)],[edge_end(2) dir_1(2)]);
dir_2 = marble_pos - edge_end;
%dir_2 = dir_2 + edge_end;
%linetemp2 = line([edge_end(1) dir_2(1)],[edge_end(2) dir_2(2)]);

dir_3 = marble_old_pos - edge_start;
%dir_3 = dir_3 + edge_start;
dir_4 = marble_pos - edge_start;
%dir_4 = dir_4 + edge_start;

% delete(linetemp2)
% delete(linetemp3)

if (det([dir_1;dir_2])*det([dir_3;dir_4])) <= 0 %%different orientations
    dir_1 = edge_end - marble_old_pos;
    dir_2 = edge_start - marble_old_pos;
    
    dir_3 = edge_end - marble_pos;
    dir_4 = edge_start - marble_pos;
    
    if (det([dir_1;dir_2])*det([dir_3;dir_4])) <= 0
       %%Intersection found
        col_occured = true;
        intersection_pos = find_intersection(marble_old_pos,marble_pos,edge_start,edge_end);
    end
    
    
    
end

end