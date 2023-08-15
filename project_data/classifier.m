 

 voice = audioread("recordings\p232_001.wav");
 noise = randn(1600, 1);

 train_data = [];
 labels = [];

 for i = -175:5:180
    H_front = getHRIR(80, 0, i, "front");
    H_back = getHRIR(80, 0, i, "middle");


    H_front = downsample(H_front.data, 3);
    H_back = downsample(H_back.data, 3);

    T_front = conv2(H_front, voice);
    T_front = T_front + 0.001 * randn(length(T_front), 2);

    T_back = conv2(H_back, voice);
    T_back = T_back + 0.001 * randn(length(T_back), 2);

    signals = [T_front(:, 1), T_back(:, 1), T_front(:, 2), T_back(:, 2)];
    features = generate_features(signals);

    % features = [gccphat(T_front(:,1), T_front(:,2)) 
    %             gccphat(T_back(:,1), T_back(:,2)) 
    %             gccphat(T_front(:,1), T_back(:,1)) 
    %             gccphat(T_front(:,2), T_back(:,2))];
    
    
    if(-150 < i && i < -90)
        label = 1;
    elseif(-90 < i && i < -30)
        label = 2;
    elseif(-30 < i && i < 30)
        label = 3;
    elseif(30 < i && i < 90)
        label = 4;
    elseif(90 < i && i < 150)
        label = 5;
    else 
        label = 6;
    end

    train_data = [train_data; features.'];
    labels = [labels; label];
 end

 classifier = TreeBagger(250, train_data, labels);
 

 eval_data = load("evaluation_data.mat");

 classifier(eval_data);
 


 