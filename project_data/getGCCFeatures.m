function features = getGCCFeatures(signals)
    sig = [signals(:,1) signals(:,2) signals(:,1) signals(:,3)];
    refsig = [signals(:,3) signals(:,4) signals(:,2) signals(:,4)];    
    
    features = gccphat(sig, refsig, 48000);    
end