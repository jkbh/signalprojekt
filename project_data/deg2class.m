% Calculates the labels used for the classification based on the angle.
% 
%
% Inputs: 
%   angles : vector of angles to generated the labels for
%
% Outputs:
%   classes: the labels of the given angles
%
function classes = deg2class(angles)
    angle_partitions = [-150, -90, -30, 30, 90, 150];
    angle_classes = [1,2,3,4,5,6,1];

    [~, classes] = quantiz(angles, angle_partitions, angle_classes);
end