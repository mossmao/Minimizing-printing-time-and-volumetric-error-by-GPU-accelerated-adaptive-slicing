data_folder = 'Pawn head';

loadParametersAndData;

% slicing
[layer_number,printing_time,printing_error,slice_indicator]=runDynamicOpt(layerArea,volumeError,min_Slice,0.5,area_to_time,v_voxel);
slice_pos = find(slice_indicator)-1;layer_thickness = slice_pos(2:end)-slice_pos(1:end-1);
layer_number

% evaluate the solution
[print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice)

% save the results to a txt file
slice_height=find(slice_indicator)*b;layer_tickness=diff(slice_height);
dlmwrite('layer_thickness_output.txt',layer_tickness'/25.4);

% % for illustration purpose only: downsample the layers
% slice_height=find(slice_indicator)*b;layer_tickness=diff(slice_height);
% n_together = 3;
% nFine = floor(length(layer_tickness)/n_together)*n_together;
% layer_tickness_coarse = sum(reshape(layer_tickness(1:nFine),n_together,[]));
% length(layer_tickness_coarse)
% dlmwrite('layer_thickness_coarse.txt',layer_tickness_coarse'/25.4);


% plot the solution
figure;stairs(slice_pos(2:end)*b,layer_thickness*b,'.-')
axis([0 length(layerArea)*b 0 0.35 ])
xlabel('Height (mm)');
ylabel('Layer thickness (mm)')

%% optional plot
% 
% figure;plot([0:(length(layerArea)-1)]'*b,volumeError(:,40)*v_voxel,'LineWidth',2);
% axis([0 length(layerArea)*b -0.1 5 ])
% xlabel('Height');
% ylabel('Volumetric Error (mm^3)')
% 
% figure;stairs(layer_thickness*b,slice_pos(2:end)*b,'.-')
% axis([0 0.35 0 length(layerArea)*b ])
% ylabel('Height (mm)');
% xlabel('Layer thickness (mm)')
% 
% figure;plot(volumeError(:,40)*v_voxel,[0:(length(layerArea)-1)]'*b,'LineWidth',2);
% axis([-0.1 5 0 length(layerArea)*b ])
% ylabel('Height');
% xlabel('Volumetric Error (mm^3)')



