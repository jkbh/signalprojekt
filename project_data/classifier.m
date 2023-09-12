%% Data Generation
fprintf("Starting data generation\n");
[samples, labels] = generateData('./recordings', 10);

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

testLoss = testSignals(model, testFeatures, testLabels);

%% Evaluation
fprintf("Starting evaluation\n");
evalSamples = loadEvaluationSignals();
evalFeatures = cell2mat(cellfun(@getGCCFeatures, evalSamples, 'UniformOutput', false));

evalPreds = predict(model, evalFeatures);