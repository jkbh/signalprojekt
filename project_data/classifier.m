cv = cvpartition(length(features), "HoldOut", 0.3);
indexTrain = training(cv);
indexVal = test(cv);

X_train = features(indexTrain,:);
y_train = labels(1,indexTrain);
X_val = features(indexVal,:);
y_val = labels(1,indexVal,:);

random_forest = TreeBagger(50, X_train, y_train);

val_preds = str2double(predict(random_forest, X_val));
val_correct = val_preds == y_val.';
val_score = sum(val_correct)/length(val_correct);    

% development data
[preds, gt] = test_classifier(random_forest);
test_correct = preds == gt;
test_score = sum(test_correct)/length(test_correct);

val_score
test_score


