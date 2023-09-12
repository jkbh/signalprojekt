% Loads the currently used evaluation signals from the .mat file
%
%
% Outputs:
%   signals : cell containing the 10 evaluation signals
%
function signals = loadEvaluationSignals()
    dev_data = load("evaluation_data.mat");
    fields = fieldnames(dev_data);
    signals = cell(numel(fields),1);
    for i = 1:numel(fields)
        signals{i} = dev_data.(fields{i}).y.';
    end
end