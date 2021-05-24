data_folder = 'Pawn head';
loadParametersAndData;


figure;plot([0:(length(layerArea)-1)]',layerArea*ww*ww,'k','LineWidth',2);
axis([0 length(layerArea) 0 1200 ])
xlabel('Cutting planes');
ylabel('Area (mm^2)')


figure;plot(repmat(height',1,size(volumeError,2)),volumeError);

figure;plot([0:(length(layerArea)-1)]',volumeError(:,40)*v_voxel,'LineWidth',2);
axis([0 length(layerArea) -0.1 5 ])
xlabel('Cutting planes');
ylabel('Volumetric Error (mm^3)')


figure;plot([0:(length(layerArea)-1)]',volumeError(:,40)*v_voxel,'LineWidth',2);
axis([0 length(layerArea) -0.1 5 ])
xlabel('Cutting planes');
ylabel('Volumetric Error (mm^3)')

figure;plot(volumeError(:,[10 20 30 40] )*v_voxel,b*[0:(length(layerArea)-1)]','LineWidth',2);
axis([ -0.1 5 0 length(layerArea)*b])
ylabel('Height (mm)');
xlabel('Volumetric Error (mm^3)')
legend({'50um','100um','150um','200um'})


figure;plot([0:(length(layerArea)-1)]',volumeError(:,[10 20 30 40] )*v_voxel,'LineWidth',2);
axis([ 0 length(layerArea) -0.1 5])
xlabel('Cutting planes');
ylabel('Volumetric Error (mm^3)')
legend({'50um','100um','150um','200um'})

figure;plot([0:(length(layerArea)-1)]',layerArea*area_to_time,'k','LineWidth',2);
axis([0 length(layerArea) 0 0.4 ])
xlabel('Cutting planes');
ylabel('Printing time (mins)')