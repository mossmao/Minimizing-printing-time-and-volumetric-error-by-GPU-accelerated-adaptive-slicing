function [final_layer_number,slice_indicator]=runDynamicOpt_Mao_CAD(error_threshold_per_layer,volumeError,min_Slice,alpha,area_to_time,v_voxel)

N = size(volumeError,1);
m = size(volumeError,2);

opt_layers = inf(N,1);    
pre_slice = zeros(N,1);
opt_layers(1)=0;

w_E = alpha;
w_A = (1-alpha);

for ii=2:N
    for jj=1:m        
        slice = ii - (jj-1)-min_Slice;
        if ((slice>0) && (volumeError(ii,jj)*v_voxel<=error_threshold_per_layer))
            if (opt_layers(ii) > (opt_layers(slice)+1))
                opt_layers(ii)=opt_layers(slice)+1;
                pre_slice(ii) = slice;
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

final_layer_number = sum(slice_indicator);    
end