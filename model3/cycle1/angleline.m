%******** get all cell position and other parameters
%load('lifeevo.mat')
x1=zeros;
y1=zeros;
area=zeros;
perameter=zeros;
aspectratio=zeros;
alpha1=zeros;
latticesize=51;

for i=1:size(exportdata(:,1))
    cellindex=mod(i,(latticesize-2)*(latticesize-2))+1;
    celltime=exportdata(i,4)/100;
    x1(cellindex,celltime)=exportdata(i,1);
    y1(cellindex,celltime)=exportdata(i,2);
    alpha1(cellindex,celltime)=exportdata(i,3);
end
%************* 


%--------------

anglet=20;
figure
x2=zeros;
y2=zeros;
x0=zeros;
y0=zeros;
L=0.6;
%cmap = colormap(flipud(viridis)); % take your pick (doc colormap)
cmap = colormap(flipud(red2blue));
zmap = linspace( 0, 1, length(cmap));

for i=1:size(x1,1)
    if x1(i,anglet)>0
x0(i,anglet)=x1(i,anglet)-(L*cos(alpha1(i,anglet)));
y0(i,anglet)=y1(i,anglet)-(L*sin(alpha1(i,anglet)));

x2(i,anglet)=x1(i,anglet)+(L*cos(alpha1(i,anglet)));
y2(i,anglet)=y1(i,anglet)+(L*sin(alpha1(i,anglet)));

color = interp1(zmap, cmap,2*abs(abs(mod(alpha1(i,anglet),pi)/pi)-1/2));
plot([x0(i,anglet) x2(i,anglet)],[y0(i,anglet) y2(i,anglet)],'color',color,LineWidth=3)
hold on
    end
end
   
    colorbar()
    set(gca, 'YDir','reverse')
    axis equal
    xlim([1 latticesize])
    ylim([1 latticesize])

% for i=anglet:1:anglet
%     coords=zeros;
%     figure
%      nPart=size(x1(:,i),1);
%      coords(1,1:nPart)=x1(:,i);
%      coords(2,1:nPart)=y1(:,i);
%      coords(coords==0) = nan;
%     plot2Dparts(coords,nPart) 
%     set(gca, 'YDir','reverse')
%     axis equal
%     xlim([0 21])
%     ylim([0 21])
%     xlabel('X (\mu m)')
%     ylabel('Y (\mu m)')
%     box on
% end
xlabel('X')
ylabel('Y')