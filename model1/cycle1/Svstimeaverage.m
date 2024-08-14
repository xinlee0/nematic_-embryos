%SI in the middle region as a function of time.

%******** get all cell position and other parameters
oriorderm=zeros(20,100);

for cyclefinal=1:20
x1=zeros;
y1=zeros;
area=zeros;
perimeter=zeros;
aspectratio=zeros;
alpha=zeros;
alpha1=zeros;

for i=1+(cyclefinal-1)*36100:36100+(cyclefinal-1)*36100
    cellindex=mod(i,361)+1;
    celltime=exportdata(i,4)/100;
    x1(cellindex,celltime)=exportdata(i,1);
    y1(cellindex,celltime)=exportdata(i,2);
    alpha1(cellindex,celltime)=exportdata(i,3);
end
%************* 

%******* fill the missing position of cells
init=1;
endt=100;


%celltimeindex=45;
%cellshapeindex=zeros;
cellpositionindex=zeros;
%aspectratiotime=zeros;

alpha2=zeros;
oriorder=zeros;

for j=1:size(alpha1,2) 
    k=1;
 for i=1:size(alpha1,1)
    %if area(i,j)>0 %&&x(i,j)>=250&&x(i,j)<=360
    %cellshapeindex(k,j)=perimeter(i,j)/sqrt(4*pi*area(i,j));
    alpha2(k,j)=alpha1(i,j);
    oriorder(k,j)=(2*cos(alpha2(k,j))*cos(alpha2(k,j))-1);
    k=k+1;
    %end
    
 end
end

%cellshapeindexm=zeros(1,endt);
cellshapeindexm2=zeros(1,endt);


%oriorderm2=zeros(1,60);
for i=1:size(alpha1,1)
    for j=1:size(alpha1,2)
       % if cellshapeindex(i,j)>0
        %cellshapeindexm(1,j)=cellshapeindexm(1,j)+cellshapeindex(i,j);
        oriorderm(cyclefinal,j)=oriorderm(cyclefinal,j)+oriorder(i,j);
        cellshapeindexm2(1,j)=cellshapeindexm2(1,j)+1;
        %end
    end
end

%cellshapeindexstd=zeros;
oriorderstd=zeros;

for i=1:endt
    %cellshapeindexm(1,i)=cellshapeindexm(1,i)/cellshapeindexm2(1,i);
    oriorderm(cyclefinal,i)=oriorderm(cyclefinal,i)/cellshapeindexm2(1,i);
    %cellnumber=sum(alpha1(:,i)~=0);
    %cellshapeindexstd(1,i)= std(cellshapeindex(1:cellnumber,i))/sqrt(cellnumber);
    %oriorderstd(1,i)=std(oriorder(1:cellnumber,i))/sqrt(cellnumber);
end

xfit=1:1:100;

% figure(2)
% fill([xfit, flip(xfit)], [cellshapeindexm+cellshapeindexstd, flip(cellshapeindexm-cellshapeindexstd)], [0.8 0.8 0.8])
% hold on
% plot(xfit,cellshapeindexm,'o-')

%figure(3)
%fill([xfit, flip(xfit)], [oriorderm+oriorderstd, flip(oriorderm-oriorderstd)], [0.8 0.8 0.8])
hold on
plot(xfit,oriorderm(cyclefinal,:),'o--',Color=[0.8,0.8,0.8],MarkerSize=6)

end

oriordermfinal=zeros(1,100);
oriorderstd=zeros(1,100);
for i=1:20
    for j=1:endt
    oriordermfinal(1,j)=oriordermfinal(1,j)+oriorderm(i,j)/20;

    %cellshapeindexstd(1,i)= std(cellshapeindex(1:cellnumber,i))/sqrt(cellnumber);
    oriorderstd(1,j)=std(oriorderm(1:20,j))/sqrt(20);
    end
end

xfit=1:1:100;

% figure(2)
% fill([xfit, flip(xfit)], [cellshapeindexm+cellshapeindexstd, flip(cellshapeindexm-cellshapeindexstd)], [0.8 0.8 0.8])
% hold on
% plot(xfit,cellshapeindexm,'o-')

%figure(3)
fill([xfit, flip(xfit)], [oriordermfinal+oriorderstd, flip(oriordermfinal-oriorderstd)], [0.8 0.8 0.8])
hold on
plot(xfit,oriordermfinal(1,:),'o-',MarkerSize=12)
