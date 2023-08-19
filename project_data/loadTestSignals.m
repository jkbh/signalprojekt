function [signals, labels] = loadTestSignals()
    dev_data = load("development_data.mat");
    fields = fieldnames(dev_data);
    signals = cell(numel(fields),1);
    sourceAngles = zeros(numel(fields), 1);
    for i = 1:numel(fields)
        signals{i} = dev_data.(fields{i}).y.';
        sourceAngles(i) = dev_data.(fields{i}).source.azimuth;        
    end 
    labels = deg2class(rad2deg(sourceAngles));
end