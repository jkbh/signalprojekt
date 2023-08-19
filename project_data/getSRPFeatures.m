% function features = getSRPFeatures(signals)
micPositions = [0 0
                0.23 0
                0 -0.009
                0.23 -0.009];

center = mean(micPositions);

emissionSourcesNoOffset = [
    0 -1
    -sqrt(3)/2 -1/2
    -sqrt(3)/2 1/2
    0 1
    sqrt(3)/2 1/2
    sqrt(3)/2 -1/2];

emissionSources = emissionSourcesNoOffset + center;

figure;
scatter(emissionSources(:,1), emissionSources(:,2))
hold on;
scatter(micPositions(:,1), micPositions(:,2))
hold on;
scatter(center(1), center(2));

P = NaN(6, 6);

micPairs = [
    1 2
    3 4
    1 3
    2 4
    1 4
    2 3];
fs = 48000;
for iEmitter = 1:6
    for iPair = 1:length(micPairs)
            emitter = emissionSources(iEmitter,:);
            iMic1 = micPairs(iPair,1);
            iMic2 = micPairs(iPair,2);
            m1 = micPositions(iMic1);
            m2 = micPositions(iMic2);
            [tau, R, lag] = gccphat(samples{30}(:, iMic1), samples{30}(:, iMic2), 48000);
            tdoa = getTDOA(emitter, m1, m2, fs);

            P(iEmitter, iPair) = R(abs(tdoa));            
    end
end

P = sum(P, 1);
% end