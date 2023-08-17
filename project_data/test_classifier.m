function [pred, gt] = test_classifier(classifier)
    dev_data = load("development_data.mat");
    fields = fieldnames(dev_data);
    pred = zeros(6,1);
    gt = zeros(6,1);
    for i = 1:numel(fields)
        signal = dev_data.(fields{i}).y;
        features = generate_features(signal.');        
        pred(i) = str2double(predict(classifier, features.'));
        gt(i) = deg2class(rad2deg(dev_data.(fields{i}).source.azimuth));
    end
end