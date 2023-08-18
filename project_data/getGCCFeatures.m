function features = getGCCFeatures(signals)
    dFront = gccphat(signals(:,1), signals(:,3));
    dBack = gccphat(signals(:,2), signals(:,4)); 
    dLeft = gccphat(signals(:,1), signals(:,2));
    dRight = gccphat(signals(:,3), signals(:,4));

    features = [dFront dBack dLeft dRight];    
end