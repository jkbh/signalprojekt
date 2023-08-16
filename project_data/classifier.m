
voice = audioread('recordings/p232_100.wav');

angles = -175:5:180;
n_angles = length(angles);
labels = deg2class(angles);

features = zeros(n_angles, 4);

for i = 1:n_angles
    angle = angles(i);
    hrir = [getHRIR(80, 0, angle, "front").data getHRIR(80, 0, angle, "middle").data]; 

    hrir = hrir(:,[1 3 2 4]); % Create order of sources as in evaluation data
    hrir = downsample(hrir, 3);
    
    clean_mic_signals = convn(hrir, voice);
    noisy_mic_signals = clean_mic_signals + 0.005 * randn(size(clean_mic_signals));    
  
    features(i,:) = generate_features(noisy_mic_signals).';
end

random_forest = TreeBagger(50, features, labels);

outputs = test_classifier(random_forest);



