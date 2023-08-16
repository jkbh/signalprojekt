function classes = deg2class(angles)
    angle_partitions = [-150, -90, -30, 30, 90, 150];
    angle_classes = [1, 2, 3, 4, 5, 6, 1];

    [~, classes] = quantiz(angles, angle_partitions, angle_classes);
end