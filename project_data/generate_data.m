files = dir('recordings/*.wav');

angles = -175:5:180;
n_angles = length(angles);

n = numel(files);

n_scenarios = 10*n_angles;

labels_angles = repmat(angles, 1, 10);
labels = deg2class(labels_angles);

SNRs = [15 20 25 30];
elevations = -10:10:20;
distances = [80 300];

voice_data = randi(n, 1, n_scenarios);
snr_data = randi(length(SNRs), 1, n_scenarios);
elevation_data = randi(length(elevations), 1, n_scenarios);
distance_data = randi(length(distances), 1, n_scenarios);

features = zeros(n_scenarios, 8);

reverb = reverberator('WetDryMix', 0.1, 'Diffusion', 0.01, 'SampleRate', 16000);

for i = 1:n_scenarios    
    angle = angles(mod(i-1, 72) + 1);

    % Load parameters for scenario
    voice = audioread("recordings/" + files(voice_data(i)).name);   
    distance = distances(distance_data(i));
    SNR = SNRs(snr_data(i));
    elevation = elevations(elevation_data(i));
    
    % Load impulse reponse for given parameters
    hrir = [getHRIR(distance, elevation, angle, "front").data getHRIR(distance, elevation, angle, "middle").data];
    hrir = downsample(hrir, 3);
    
    % Create clean microphone signal
    clean = conv2(hrir, voice); 

    % Create add reverbation
    % reset(reverb);
    % clean(:,[1,2]) = reverb(clean(:,[1,2]));
    % reset(reverb);
    % clean(:,[3,4]) = reverb(clean(:,[3,4]));
   
    % Add white noise according to given SNR
    %noise = randn(size(clean)) .* std(clean)/db2mag(SNR);
    noise = randn(size(clean)) * 0.0001;
    noisy = clean + noise;

    noisy = noisy(:,[1 3 2 4]); % Create order of sources as in evaluation data

    features(i,:) = generate_features(noisy).';
    
    % sound(noisy(:,[1,2]), 16000);
    % time = length(noisy)/16000;
    % pause(time);
end