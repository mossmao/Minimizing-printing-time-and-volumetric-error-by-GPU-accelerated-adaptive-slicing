function drawErrorMap(rays,slice_indicator,Np1,plot_range)
b = 0.005;
b_inch=b/25.4;
bbox_min = min(rays');
y_min = bbox_min(2);

slice_pos = find(slice_indicator);

pre_slice_index = zeros(Np1,1);
after_slice_index = zeros(Np1,1);
pre_id = 1;
for ii = 1:Np1
    if (slice_indicator(ii) == 1)
        pre_id = ii;
        pre_slice_index(ii) = ii;
    else
        pre_slice_index(ii) = pre_id;
    end
end

after_id = Np1;
for ii = Np1:-1:1
    if (slice_indicator(ii) == 1)
        after_id = ii;
        after_slice_index(ii) = ii;
    else
        after_slice_index(ii) = after_id;
    end
end

thickness_every_slice = zeros(Np1,1);
cur = 1;
for ii = 1:length(slice_pos)
    thickness_every_slice(cur:(slice_pos(ii)-1)) = slice_pos(ii)-cur;
    cur = slice_pos(ii);
end
 
error_per_point = zeros(1,length(rays));
ny = rays(4,:);

for ii = 1:length(error_per_point)        
    index = floor((rays(2,ii)-y_min)/b_inch);
    index = max(index,1); index = min(index,Np1);
    error_per_point(ii) = thickness_every_slice(index)*abs(ny(ii));
    
    if (abs(abs(ny(ii))-1)<1e-4)
        % flat surface
        if (ny(ii)>0)
            error_per_point(ii) = after_slice_index(index)-index;
        else
            error_per_point(ii) = index-pre_slice_index(index);
        end
    end

%     if (rays(4,ii)<0)
%         error_per_point(ii) = after_slice_index(index)-index;
%     else
%         error_per_point(ii) = index-pre_slice_index(index);
%     end
%     error_per_point(ii) = error_per_point(ii)*abs(rays(4,ii));

end
error_per_point = error_per_point*b*1000;

figure;scatter3(rays(1,:),rays(2,:),rays(3,:),20,error_per_point);
axis(plot_range)
axis vis3d
colormap jet
colorbar;
view(0,-100)
axis off
caxis([0 100])
% patch('Faces',obj_.f.v,'Vertices',obj_.v,'FaceColor','b','EdgeColor','None');






