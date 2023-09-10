%% Data Generation
fprintf("Starting data generation\n");
[samples, labels] = generateData('./recordings', 5);

%% Feature Extraction
fprintf("Starting feature extraction\n");
featureNames = ["Front" "Back" "Left" "Right"];
[features] = cell2mat(cellfun(@getGCCFeatures, samples, 'UniformOutput', false));

%% Training
fprintf("Starting training\n");
tblTrain = array2table(features, 'VariableNames', featureNames);

model = fitctree(tblTrain, labels);
validationLoss = cvloss(model);

%% Testing
fprintf("Starting testing\n");
[testSamples , testLabels] = loadTestSignals();
testFeatures = cell2mat(cellfun(@getGCCFeatures, testSamples, 'UniformOutput', false));

lost = testSignals(model, testFeatures, testLabels);