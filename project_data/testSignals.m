% Tests the given `features` on the `model` and compares the prediction
%  against the `labels`. Prints a summary of the predictions.
%
%
% Inputs: 
%   model    : the classifier to test 
%   features : the features to test on the model
%   labels   : the correct labels of the features
%
% Outputs: 
%   testLoss : the calculated loss of the model on the test data
%
function testLoss = testSignals(model, features, labels)
    testLoss = loss(model, features, labels, Lossfun="classiferror");
    correct = 0;
    fprintf("-------------------\n");
    fprintf("Predicted - Correct\n");
    for i = 1:size(labels, 2)
        p = predict(model, features(i, :));
        if p == labels(i)
            correct = correct + 1;
        end
        fprintf("        %d - %d\n", p, labels(i));
    end
    fprintf("-------------------\n");
    fprintf("Accuracy:  %f (loss: %f)\n", (1/size(labels, 2))*correct, 1-testLoss);
end