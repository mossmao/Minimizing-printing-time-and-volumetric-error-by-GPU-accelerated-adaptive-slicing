function print_error=error_at_given_time_Mao_CAD(error_threshold_per_layer,layerArea,volumeError,min_Slice,alpha,area_to_time,v_voxel)
% reference method from paper
% Mao, Huachao, Tsz-Ho Kwok, Yong Chen, and Charlie CL Wang. "Adaptive slicing based on efficient profile analysis." Computer-Aided Design 107 (2019): 89-101.

[~,slice_indicator]=runDynamicOpt_Mao_CAD(error_threshold_per_layer,volumeError,min_Slice,alpha,area_to_time,v_voxel);
slice_pos = find(slice_indicator);
[~,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_Slice);
end