function [samplesCell, labels] =  generateData(voiceFolder, nSamplesPerAngle)    
    baseAngles = -175:5:180;
    
    nSamples = length(baseAngles)*nSamplesPerAngle;
    
    angles = repmat(baseAngles, 1, nSamplesPerAngle);
    labels = deg2class(angles);
    
    % Define possible parameters
    possibleVoicefiles = dir(voiceFolder + "/*.wav");
    possibleNoise = [5 10 20];
    possibleElevations = [-10 0 10 20];
    possibleDistances = [80 300];
    
    % Sample random parameters for each scenario
    voicefiles = datasample(possibleVoicefiles, nSamples);
    noiseValues = datasample(possibleNoise, nSamples);
    elevations = datasample(possibleElevations, nSamples);
    distances = datasample(possibleDistances, nSamples);
    
    samplesCell = cell(nSamples, 1);

    % reverb = reverberator("PreDelay", 0.05, "DecayFactor", 0.8, 'WetDryMix', 0.2, "SampleRate", 48000);
    
    for iScenario = 1:nSamples
        voiceFilename = [voicefiles(iScenario).folder '/' voicefiles(iScenario).name];
        voice = audioread(voiceFilename);
        voice = interp(voice, 3);
        % voice(length(voice) + 24000) = 0;
        % voiceReverb = mean(reverb(voice), 2);

        angle = angles(iScenario);
        SNR = noiseValues(iScenario);
        elevation = elevations(iScenario);
        distance = distances(iScenario);
        
        hrir = [getHRIR(distance, elevation, angle, "front").data getHRIR(distance, elevation, angle, "middle").data];
        hrir = hrir(:,[1 3 2 4]); % Create order of sources as in evaluation data
        
        cleanSignal = conv2(hrir, voice);

        % noise = randn(size(cleanSignal));
        noisySignal = awgn(cleanSignal, SNR, 'measured');

        samplesCell{iScenario} = noisySignal;
    end
end