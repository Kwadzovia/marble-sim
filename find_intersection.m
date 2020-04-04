function intersection_pos = find_intersection(line1_p1,line1_p2,line2_p1,line2_p2)

line1_det = det([line1_p1;line1_p2]);
line2_det = det([line2_p1;line2_p2]);

line1_dir = line1_p2 - line1_p1;
line2_dir = line2_p2 - line2_p1;

det_div = -det([line1_dir;line2_dir]);

intersection_pos(1) = (line1_det*line2_dir(1) - line2_det*line1_dir(1))/det_div;
intersection_pos(2) = (line1_det*line2_dir(2) - line2_det*line1_dir(2))/det_div;

end