files = dir('recordings/*.wav');

angles = -175:5:180;
n_angles = length(angles);

n = numel(files);

n_scenarios = 10*n_angles;

labels_angles = repmat(angles, 1, 10);
labels = deg2class(labels_angles);

snrs = 0:0.001:0.002;
elevations = -10:10:20;
distances = [80 300];

voice_data = randi(n, 1, n_scenarios);
snr_data = randi(length(snrs), 1, n_scenarios);
elevation_data = randi(length(elevations), 1, n_scenarios);
distance_data = randi(length(distances), 1, n_scenarios);

features = zeros(n_scenarios, 4);

for i = 1:n_scenarios
    angle = angles(mod(i-1, 72) + 1);
    voice = audioread("recordings/" + files(voice_data(i)).name);   
    distance = distances(distance_data(i));
    snr = snrs(snr_data(i));
    elevation = elevations(elevation_data(i));

    hrir = [getHRIR(distance, elevation, angle, "front").data getHRIR(distance, elevation, angle, "middle").data];
    hrir = hrir(:,[1 3 2 4]); % Create order of sources as in evaluation data
    hrir = downsample(hrir, 3);
    
    clean_mic_signals = conv2(hrir, voice);
    noisy_mic_signals = clean_mic_signals + snr * randn(size(clean_mic_signals));
    features(i,:) = generate_features(noisy_mic_signals).';
end