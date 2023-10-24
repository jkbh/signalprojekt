%% Data Generation
fprintf("Starting data generation\n");
[samples, labels] = generateData('./recordings', 50);

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
angles = class2deg(evalPreds);
rad = deg2rad(angles);

% NOTE: the degree range for label 1 will be printed as `-179-180` but 
%        it actually is -150 - -179 and 151 - 180
fprintf("---------------------------------------------\n");
for i = 1:size(angles, 1) 
    fprintf("eval_%02d: deg: %d° (rad: %f)\n", i, angles(i), rad(i));
end 
fprintf("---------------------------------------------\n");