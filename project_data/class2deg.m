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
    angles = [-180, -120, -60, 0, 60, 120];
    degrees = zeros(size(classes, 1));
    for i = 1:size(classes, 1)
        degrees(i) = angles(classes(i));
    end
end


