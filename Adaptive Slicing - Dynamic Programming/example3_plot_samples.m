data_folder = 'Pawn head';
rays=dlmread([data_folder '/' 'rays.txt']);

cc=reshape(rays(:,1:3)',6,[]);
dd=[cc;nan(3,length(cc))];ee=reshape(reshape(dd,[],1),3,[]);
figure;
plot3(ee(1,:),ee(2,:),ee(3,:),'k.'); hold on;
p1=plot3(ee(1,:),ee(2,:),ee(3,:),'g-','LineWidth',2); hold on;
p1.Color(4) = 0.25;
axis vis3d
axis off