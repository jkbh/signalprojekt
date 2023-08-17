function features = generate_features(signals)
    %signals = normalize(signals, "range")*100;
    features = [gccphat(signals(:,1), signals(:,3)) % vorne vorne
                gccphat(signals(:,2), signals(:,4)) % hinten hinten
                gccphat(signals(:,1), signals(:,2)) % links
                gccphat(signals(:,3), signals(:,4))]; % rechts
end