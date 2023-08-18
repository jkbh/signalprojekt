%% Data Generation
[samples, labels] = generateData('./recordings', 10);

%% Feature Extraction
featureNames = ["Front" "Back" "Left" "Right"];
[features] = cell2mat(cellfun(@getGCCFeatures, samples, 'UniformOutput', false));

%% Training
tblTrain = array2table(features, 'VariableNames', featureNames);

model = fitctree(tblTrain, labels);
validationLoss = cvloss(model);

%% Testing
[testSamples , testLabels] = loadTestSignals();
testFeatures = cell2mat(cellfun(@getGCCFeatures, testSamples, 'UniformOutput', false));

testLoss = loss(model, testFeatures, testLabels);