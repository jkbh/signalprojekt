function hrir = getHRIR(varargin)
%
% Function loads HRIRs from the database in folder /hrir/ and returns a
% struct containing the data and information about the sound source position
%
% Use:

%   hrir = getHRIR(distance, elevation angle in degree,...
%               azimuth angle in degree, [HRIRset]);
%
%
%   with
%       distance  = {80 300}
%       elevation = {-10 0 10 20}
%       azimuth   = {-180 : 5 : 180}
%
%   NOTE:
%   Negative azimuth angles point to the left-hand side.                 
%
%
%   Input character-vector HRIRset is optional, default is 'all':
%   'all'       8-channel HRIRs                
%   'in-ear'    IRs from in-ear microphoes    
%   'bte'       6-channel BTE-IRs
%   'front'     BTE-IRs front microphone pair
%   'middle'    BTE-IRs middle microphone pair
%   'rear'      BTE-IRs rear microphone pair
%
%   NOTE:
%   Odd channel numbers always correpond to the left side,
%   even channel numbers always correpond to the right side.


% Change this path to an absolute path if you need.
baseDirectory = './hrir';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flipData = false;


if nargin == 3
    HRIRset = 'all';
elseif nargin == 4
    HRIRset = varargin{4};
else
    error(['Wrong number of input arguments.'])
end
% for positive azimuth angle, load mirror symmetric data and flip
% channels from left to right

if all(varargin{1} ~= [80 300])
    error(['Distance not available: ' num2str(varargin{1})])
elseif all(varargin{2} ~= -10 : 10 :20)
    error(['Elevation angle not available: ' num2str(varargin{2})])
elseif all(varargin{3} ~= -180 : 5 : 180)
    error(['Azimuth angle not available: ' num2str(varargin{3})])
else
    if varargin{3} > 0
        flipData = true;
        varargin{3}=-varargin{3};
    end
    hrir = load(fullfile(baseDirectory,['anechoic' '_distcm_' ...
        num2str(varargin{1}) '_el_' num2str(varargin{2}) '_az_' ...
        num2str(varargin{3}) '.mat']));
end


switch lower(HRIRset)
    case 'all'
        channels = 1:8;
    case 'in-ear'
        channels = 1:2;
    case 'bte'
        channels = 3:8;
    case 'front'
        channels = 3:4;
    case 'middle'
        channels = 5:6;
    case 'rear'
        channels = 7:8;
    otherwise
        error([HRIRset ': Non-existing set.'])
end


% flip left and right channels if azimuth > 0
if flipData
    channels = [channels(2:2:end); channels(1:2:end)];
    channels = reshape(channels,1,2*size(channels,2));
    hrir.azimuth = abs(hrir.azimuth);
end

hrir.data = hrir.data(:,channels);
hrir.nChannels = length(channels);
hrir.HRIRset = lower(HRIRset);

end