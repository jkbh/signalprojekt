cv = cvpartition(length(features), "HoldOut", 0.3);
index = cv.test;

random_forest = TreeBagger(10, features(~index,:), labels(1,~index));

test_labels = labels(1, index);

preds = str2double(predict(random_forest, features(index,:)));

outputs = preds == test_labels.';
score = sum(outputs)/length(outputs);    

outputs_dev_data = test_classifier(random_forest);



