% Calculates the GCC features by invoking `gccphat`.
%  The 4 features are the generalized cross-correlation of
%  front right (1) - middle right (3)
%  front left (2) - middle left(4)
%  front right (1) - front left (2) 
%  middle right (3) - middle left (4)
%
% Inputs: 
%   signal : the signal to calculate the gcc for
%
% Outpus:
%   features : the 4 calculated gcc features
%
function features = getGCCFeatures(signal)
    sig = [signal(:,1) signal(:,2) signal(:,1) signal(:,3)];
    refsig = [signal(:,3) signal(:,4) signal(:,2) signal(:,4)];    
    
    features = gccphat(sig, refsig, 48000);    
end