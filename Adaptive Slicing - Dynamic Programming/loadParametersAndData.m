%% parameters
b=0.005;%mm
ww=0.041;%mm
v_voxel = ww*ww*b;

rho = 0.5;
v = 3600;
width=0.48;

min_Slice = 4;

area_to_time = ww*ww*rho/width/v;

%% data
% load area
layerArea=dlmread([data_folder '/' 'layerArea.txt']);
Np1 = length(layerArea);
height = (0:(length(layerArea)-1))*b;

% load volume error
volumeError=dlmread([data_folder '/' 'volumeErrorMatrix_cuda.txt']);
volumeError = reshape(volumeError,length(layerArea),[]);
manyHeights = repmat(height',1,size(volumeError,2));