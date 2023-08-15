 data = getHRIR(80, 0, 0, "front");
 
 tau = gccphat(data.data(:, 1), data.data(:, 2))

 voice = audioread("recordings\p232_001.wav");
 noise = randn(1600, 1);


 for i = -30:5:30
    H_front = getHRIR(80, 0, i, "front");
    H_back = getHRIR(80, 0, i, "middle");


    H_front = downsample(H_front.data, 3);
    H_back = downsample(H_back.data, 3);

    T_front = conv2(H_f, voice);
    T_front = T_front + 0.001 * randn(length(T_front), 2);

    T_back = conv2(H_b, voice);
    T_back = T_back + 0.001 * randn(length(T_back), 2);

    features = [gccphat(T_front(:,1), T_front(:,2)) 
                gccphat(T_back(:,1), T_back(:,2)) 
                gccphat(T_front(:,1), T_back(:,1)) 
                gccphat(T_front(:,2), T_back(:,2))];
    
    sound(T, 16000);
    pause(2);
 end

 