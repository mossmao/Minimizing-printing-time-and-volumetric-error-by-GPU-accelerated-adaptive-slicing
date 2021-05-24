data_folder = 'pawn v6';
loadParametersAndData;

rays=dlmread([data_folder '/' 'rays.txt']);
rays = rays';

plot_range = [0 0.9 0 0.9 0 0.9];
% adaptive slicing
[layer_number,printing_time,printing_error,slice_indicator]=runDynamicOpt(layerArea,volumeError,min_Slice,0.57,area_to_time,v_voxel);
slice_pos = find(slice_indicator);layer_thickness = slice_pos(2:end)-slice_pos(1:end-1);
figure;stairs(slice_pos(2:end)*b,layer_thickness*b,'.-');
[print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice)
drawErrorMap(rays,slice_indicator,Np1,plot_range)

slice_height=find(slice_indicator)*b;layer_tickness=diff(slice_height);
n_together = 3;
nFine = floor(length(layer_tickness)/n_together)*n_together;
layer_tickness_coarse = sum(reshape(layer_tickness(1:nFine),n_together,[]));
length(layer_tickness_coarse)
dlmwrite('layer_thickness_our.txt',layer_tickness_coarse'/25.4);

% uniform
slice_pos = 1:21:Np1;
slice_indicator = zeros(1,size(volumeError,1));
slice_indicator(slice_pos) = 1;slice_indicator(end)=1;
[print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice)
drawErrorMap(rays,slice_indicator,Np1,plot_range)

slice_height=find(slice_indicator)*b;layer_tickness=diff(slice_height);
n_together = 3;
nFine = floor(length(layer_tickness)/n_together)*n_together;
layer_tickness_coarse = sum(reshape(layer_tickness(1:nFine),n_together,[]));
length(layer_tickness_coarse)
dlmwrite('layer_thickness_uniform.txt',layer_tickness_coarse'/25.4);