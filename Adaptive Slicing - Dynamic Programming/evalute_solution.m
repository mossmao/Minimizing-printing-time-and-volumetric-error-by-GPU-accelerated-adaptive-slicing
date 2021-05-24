function [print_time,print_error]=evalute_solution(layerArea,volumeError,slice_pos, area_to_time, v_voxel,min_slice)
% given the slicing postion and related errors
% evalute the solution w.r.t print time and print error
print_time = 0;
print_error = 0;

for ii=1:(length(slice_pos)-1)
    print_time = print_time+layerArea(slice_pos(ii)+1)*area_to_time;
    print_error = print_error+volumeError(slice_pos(ii+1),slice_pos(ii+1)-slice_pos(ii)-min_slice+1)*v_voxel;
end
end