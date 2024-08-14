%function death_new
 
 
clear all;
close all;
D=2;

rng('shuffle');

nSteps =10000;
cyclenum =20; 

cellnumber=2500;   % number of cells 
latticesize=sqrt(cellnumber)+1;  % lattice size
angle=zeros(latticesize,latticesize);
angledev=zeros(latticesize,latticesize);
anglet2=zeros(latticesize,latticesize);
angletdev2=zeros(latticesize,latticesize);

visdata=zeros;
mit=0;
mit2=0;

for cyclemsd=1:cyclenum
    
    dt = 1;         % Integration time
    dt2 = dt*dt;        % Integration time, squared

    printFreq = 1000;     % Printing frequency
    plotFreq = 100;  %plot frequency
    
      for i=1:latticesize
          for j=1:latticesize
              angle(i,j) = 2*pi*(rand()-0.5);  %2021-6-2
          end  
      end

    
    
    % ===================
    % Molecular Dynamics
    % ===================
    
    
    for step = 1:nSteps
       
        if mod(step,plotFreq) == 0   
            part=1;
          for i=2:latticesize-1
              for j=2:latticesize-1
                  visdata(part,1)= i;
                  visdata(part,2)= j;
                  visdata(part,3)= angle(i,j);
                  visdata(part,4)= step*dt;
                  %visdata(part,5)= mit;
                  %visdata(part,6)= mit2;
                  %visdata(part,7)= angledev;
                  visdata_row= visdata(part,:);
                  save('lifeevo.txt','visdata_row', '-ascii','-append');
                  part = part+1;
              end
          end
        end

        
            for j=1:latticesize
                angle(1,j)= angle(latticesize-1,j);
            end

            for j=1:latticesize
                angle(latticesize,j)= angle(2,j);
            end

            for i=1:latticesize
                angle(i,1)= angle(i,latticesize-1);
            end

            for i=1:latticesize
                angle(i,latticesize)= angle(i,2);
            end

        for i=2:latticesize-1
            for j=2:latticesize-1
                mit= sin(angle(i,j)-angle(i,j-1))+sin(angle(i,j)-angle(i,j+1))+sin(angle(i,j)-angle(i-1,j))+sin(angle(i,j)-angle(i+1,j));
                anglet2(i,j)=angle(i,j)-0.5*0.005*dt*mit-angle(i,j)*dt*0.000;
            end
        end

            

        angle=anglet2;
        
        if mod(step,printFreq) == 0
            step % Print the step
            cyclemsd
        end
        

        


    end
    
  
    
    

    
end
 

