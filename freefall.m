function [linear_acceleration,angular_acceleration] = freefall( linear_acceleration, angular_acceleration, gravity)

linear_acceleration = [linear_acceleration(1) gravity];
angular_acceleration = 0;

end