function [linear_acceleration,angular_acceleration] = freefall( linear_acceleration, angular_acceleration, gravity)

linear_acceleration = [0 gravity*1000];
angular_acceleration = 0;

end