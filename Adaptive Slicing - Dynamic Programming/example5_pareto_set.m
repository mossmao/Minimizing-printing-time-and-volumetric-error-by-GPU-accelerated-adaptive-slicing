%% read data
data_folder = '3DBenchy';
loadParametersAndData;

%% Parato set
weights = 0:0.04:1;

% uniform slicing
n_weights = length(weights);
slices = min_Slice:(min_Slice+size(volumeError,2)-1);
all_printing_time_uniform = zeros(n_weights,1);
all_printing_error_uniform = zeros(n_weights,1);
for ii=1:length(slices)
    slice = slices(ii);
    slice_pos = 1:slice:size(volumeError,1);
    [print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice);
    all_printing_time_uniform(ii) = print_time;
    all_printing_error_uniform(ii) = print_error;
end


% this paper
scale = (max(all_printing_time_uniform) - min(all_printing_time_uniform))/(max(all_printing_error_uniform)-min(all_printing_error_uniform));

all_alpha = weights*scale./(1+scale*weights-weights);
n_alpha = length(all_alpha);
all_printing_time = zeros(n_alpha,1);
all_printing_error = zeros(n_alpha,1);
tic;
for i_alpha = 1:n_alpha
    alpha = all_alpha(i_alpha);
    
    [~,~,~,slice_indicator]=runDynamicOpt(layerArea,volumeError,min_Slice,alpha,area_to_time,v_voxel);
    slice_pos = find(slice_indicator);
    [print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice);
%     all_layer_number(i_alpha) = layer_number;    
    all_printing_time(i_alpha) = print_time;
    all_printing_error(i_alpha) = print_error;
    
end
tt=toc;
tt = tt/n_alpha


% minimal # of layer, constant layer area, (ref: optimal discrete slicing)
slices = min_Slice:(min_Slice+size(volumeError,2)-1);
dummy_layerArea = ones(length(layerArea),1)/area_to_time;

scale = (size(volumeError,1)/min_Slice - size(volumeError,1)/((min_Slice+size(volumeError,2)-1)))/(max(all_printing_error_uniform)-min(all_printing_error_uniform));

weights = 0:0.04:1;
all_alpha = weights*scale./(1+scale*weights-weights);
n_alpha = length(all_alpha);
all_printing_time_minLayer = zeros(n_alpha,1);
all_printing_error_minLayer = zeros(n_alpha,1);
for i_alpha = 1:n_alpha
    alpha = all_alpha(i_alpha);    
    [~,~,~,slice_indicator]=runDynamicOpt(dummy_layerArea,volumeError,min_Slice,alpha,area_to_time,v_voxel);
    slice_pos = find(slice_indicator);
    [print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice);
%     all_layer_number(i_alpha) = layer_number;    
    all_printing_time_minLayer(i_alpha) = print_time;
    all_printing_error_minLayer(i_alpha) = print_error;
end


% Mao's method: minimal # of layer, constant layer area, constrainted layer error 
all_printing_time_mao = zeros(n_alpha,1);
all_printing_error_mao = zeros(n_alpha,1);
all_error_threshold_per_layer = 0.2:0.05:1;

for i_threshold = 1:length(all_error_threshold_per_layer)
    error_threshold_per_layer = all_error_threshold_per_layer(i_threshold);
    [final_layer_number,slice_indicator]=runDynamicOpt_Mao_CAD(error_threshold_per_layer,volumeError,min_Slice,alpha,area_to_time,v_voxel);
    slice_pos = find(slice_indicator);
    [print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice);
    all_printing_time_mao(i_threshold) = print_time;
    all_printing_error_mao(i_threshold) = print_error;
end


%% plot all together
figure;
markersize = 5;
plot(all_printing_time_uniform,all_printing_error_uniform,'cd','MarkerSize',markersize);
hold on;

plot(all_printing_time_mao,all_printing_error_mao,'b*','MarkerSize',markersize);
plot(all_printing_time_minLayer,all_printing_error_minLayer,'k.','MarkerSize',markersize);
plot(all_printing_time,all_printing_error,'-ro','MarkerSize',markersize);
xlabel('Printing time (minutes)');
ylabel('Volumetric Error(mm^3)');
legend('Uniform Slicing','Ref [3]','Ref [8]','Our');
axis([0.1 100 0 100])