function [final_layer_number,final_printing_time,final_printing_error,slice_indicator]=runDynamicOpt(layerArea,volumeError,min_Slice,alpha,area_to_time,v_voxel)
N = size(volumeError,1);
m = size(volumeError,2);

Cost = inf(N,1);    
print_time = zeros(N,1);
print_error = zeros(N,1);
pre_slice = zeros(N,1);
Cost(1)=0;

w_E = alpha;
w_A = (1-alpha);
w_P = 0;%(1-alpha);

layerArea = layerArea*area_to_time;
volumeError = volumeError*v_voxel;

for ii=2:N
    for jj=1:m        
        slice = ii - (jj-1)-min_Slice;
        if (slice>0)
            layer_cost = volumeError(ii,jj)*w_E+layerArea(slice+1)*w_A;%+perimeters(slice+1)*w_P;
            if (Cost(ii) > (Cost(slice)+layer_cost ))
                Cost(ii)=Cost(slice)+layer_cost;
                pre_slice(ii) = slice;
%                 print_time(ii) = print_time(slice) + (layerArea(slice+1)*w_A+perimeters(slice+1)*w_P)/(1-alpha);
                print_time(ii) = print_time(slice) + layerArea(slice+1);
                print_error(ii) = print_error(slice) + volumeError(ii,jj);
            end
        end
    end
end

slice_indicator = zeros(N,1);
slice = N;
while (slice >= 1)
    slice_indicator(slice) = 1;
    slice = pre_slice(slice);
end

final_layer_number = sum(slice_indicator)-1;    
final_printing_time = print_time(end);
final_printing_error = print_error(end);
end