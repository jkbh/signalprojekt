% Calculates the degrees of the given classes (labels).
% 
%
% Inputs: 
%   classes : vector of classes to generated the degrees for
%
% Outputs:
%   classes: the degrees of the given classes
%
function degrees = class2deg(classes)
    angle_ranges = [151:180 -179:-150; %1
                    -149:-90; %2
                    -89:-30; %3
                    -29:30; %4
                     31:90; %5
                     91:150]; %6
    degrees = zeros(size(classes, 1), 60);
    for i = 1:size(classes, 1)
        degrees(i, :) = angle_ranges(classes(i), :);
    end
end


