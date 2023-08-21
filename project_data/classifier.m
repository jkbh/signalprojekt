%% Data Generation
[samples, labels] = generateData('./recordings', 10);

%% Feature Extraction
nSamples = length(samples);
featuresFull = [];
labelsFull = [];
for iSample = 1:nSamples
    featuresLocal = getGCCFeatures(samples{iSample});
    featuresFull = [featuresFull; featuresLocal];
    nBlocks = length(featuresLocal);
    labelsFull = [labelsFull; repmat(labels(iSample), nBlocks, 1)];
end
%[features] = cell2mat(cellfun(@getGCCFeatures, samples, 'UniformOutput', false));

%% Training
model = fitctree(featuresFull, labelsFull);
validationLoss = cvloss(model);

%% Testing
[testSamples , testLabels] = loadTestSignals();
nTestSamples = length(testSamples);
testResults = NaN(nTestSamples, 2);
for iSample = 1:nTestSamples
    testFeatures = getGCCFeatures(testSamples{iSample});
    testFeatures(~any(testFeatures, 2), :) = [];% Remove all zero rows (no voice)
    testFeatures(any(abs(testFeatures) == 1024, 2), :) = []; % Remove all 1024 delaya (error)
    testPreds = predict(model, testFeatures);
    [m, pred] = max(histcounts(testPreds, 6));
    testResults(iSample, :) = [pred testLabels(iSample)];
end