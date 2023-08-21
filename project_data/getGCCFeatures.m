function features = getGCCFeatures(signals)
    nSamples = length(signals);
    blockSize = 1024;
    nBlocks = floor(nSamples/blockSize);
    signals(nBlocks * blockSize) = 0;
    features = NaN(nBlocks-1, 4);
    for iBlock = 1:nBlocks-1
        index = iBlock * blockSize:(iBlock+1)*blockSize;
        sig = [signals(index,1) signals(index,2) signals(index,1) signals(index,3)];
        refsig = [signals(index,3) signals(index,4) signals(index,2) signals(index,4)];
        features(iBlock, :) = gccphat(sig, refsig, 1);  
    end

    features(~any(features, 2), :) = [];% Remove all zero rows (no voice)
    features(any(abs(features) == 1024, 2), :) = []; % Remove all 1024 delaya (error)
end