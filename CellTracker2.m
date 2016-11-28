cellId=zeros(1,1,1,'double');
h=0;
similar=0;
tracked=0;
LongTracker=longTermHolder;
%initalize column to track if longterm main record has been associated with
%track
for r=1:length(longTermHolder)
    longTermHolder(r,9)=0;
end
cellCounter=1;
%initalize front layer of tracking cube 
for t=1:cellPerTime1(1)
     cellId(t,1,1)=longTermHolder(t,1);
     cellId(t,2,1)=longTermHolder(t,2);
     cellId(t,3,1)=longTermHolder(t,3);
     cellId(t,4,1)=longTermHolder(t,4);
     cellId(t,5,1)=longTermHolder(t,5);
     cellId(t,6,1)=longTermHolder(t,6);
     cellId(t,7,1)=longTermHolder(t,7);
     cellId(t,8,1)=longTermHolder(t,8);
     cellId(t,9,1)=cellCounter;
     cellCounter=cellCounter+1;
     longTermHolder(t,9)=1;
end
layers=1;%set layer to 1 becuase first layer of cube has been created 
mover=0;%create window for each round of detection
found=0;%Track number of new tracks created
for w=1:(length(cellPerTime1)-2)
    %Iterate through every timestamp
    nextlayer=layers+1;

    %add next layer of cube
    LayerDensity=cellPerTime1(layers);%Get number of cells detected 
    mover=mover+LayerDensity;%Used to Shift window of cellPerTime to next 
    newCellAdder=1;%Create row incremeter for each layer
    for i=1:size(cellId,1)
        storedX=cellId(i,1,layers);
        storedY=cellId(i,2,layers);
        %Grab x and y stored in current layer of cube 
     for j=1:cellPerTime1(nextlayer)
            checkingX=longTermHolder(j+mover,1);
            checkingY=longTermHolder(j+mover,2);
            Xdist=((storedX-checkingX).^2);
            Ydist=((storedY-checkingY).^2);
            Dist=(Xdist+Ydist);
            %Check timestamp for cell in area surounding tracked cell 
        if Dist<20
                LongDiff=(cellId(i,6,layers)/(longTermHolder(j+mover,6)));
                ShortDiff=(cellId(i,7,layers)/longTermHolder(j+mover,7));
                DimDiff=abs((LongDiff+ShortDiff));
                if DimDiff<5
                    if(longTermHolder(j+mover,9)==0)
                        cellId(newCellAdder,1,nextlayer)=longTermHolder(j+mover,1);
                        cellId(newCellAdder,2,nextlayer)=longTermHolder(j+mover,2);
                        cellId(newCellAdder,3,nextlayer)=longTermHolder(j+mover,3);
                        cellId(newCellAdder,4,nextlayer)=longTermHolder(j+mover,4);
                        cellId(newCellAdder,5,nextlayer)=longTermHolder(j+mover,5);
                        cellId(newCellAdder,6,nextlayer)=longTermHolder(j+mover,6);
                        cellId(newCellAdder,7,nextlayer)=longTermHolder(j+mover,7);
                        cellId(newCellAdder,8,nextlayer)=longTermHolder(j+mover,8);
                        cellId(newCellAdder,9,nextlayer)=cellId(i,9,layers);
                        tracked=tracked+1;
                        longTermHolder(j+mover,9)=1;
                        newCellAdder=newCellAdder+1;
                    end
                end
        end 
     end
    end
    for l=1:cellPerTime1(nextlayer)
        if longTermHolder(l+mover,9)==0
            cellId(newCellAdder,1,nextlayer)=longTermHolder(l+mover,1);
            cellId(newCellAdder,2,nextlayer)=longTermHolder(l+mover,2);
            cellId(newCellAdder,3,nextlayer)=longTermHolder(l+mover,3);
            cellId(newCellAdder,4,nextlayer)=longTermHolder(l+mover,4);
            cellId(newCellAdder,5,nextlayer)=longTermHolder(l+mover,5);
            cellId(newCellAdder,6,nextlayer)=longTermHolder(l+mover,6);
            cellId(newCellAdder,7,nextlayer)=longTermHolder(l+mover,7);
            cellId(newCellAdder,8,nextlayer)=longTermHolder(l+mover,8);
            cellId(newCellAdder,9,nextlayer)=cellCounter;
            cellCounter=cellCounter+1;
            longTermHolder(l+mover,9)=1;
            found=found+1;
            newCellAdder=newCellAdder+1;
        end
    
    end
    layers=nextlayer;
end 





% mover2=cellPerTime1(2);
% moverAll=(mover+mover2);
% newCellAdder=1;
% for p=1:layers
%     for i=1:length(cellId)
%         storedX=cellId(i,1,p);
%         storedY=cellId(i,2,p);
%      for j=1:cellPerTime1(3)
%             checkingX=longTermHolder(j+moverAll,1);
%             checkingY=longTermHolder(j+moverAll,2);
%             Xdist=((storedX-checkingX).^2);
%             Ydist=((storedY-checkingY).^2);
%             Dist=(Xdist+Ydist);
%             if Dist<20
%             LongDiff=(cellId(i,6,1)/(longTermHolder(j+moverAll,6)));
%             ShortDiff=(cellId(i,7,1)/longTermHolder(j+moverAll,7));
%             DimDiff=abs((LongDiff+ShortDiff));
%             if DimDif<5
%                 if(longTermHolder(j+moverAll,9)==0)
%                     cellId(newCellAdder,1,3)=longTermHolder(j+moverAll,1);
%                     cellId(newCellAdder,2,3)=longTermHolder(j+moverAll,2);
%                     cellId(newCellAdder,3,3)=longTermHolder(j+moverAll,3);
%                     cellId(newCellAdder,4,3)=longTermHolder(j+moverAll,4);
%                     cellId(newCellAdder,5,3)=longTermHolder(j+moverAll,5);
%                     cellId(newCellAdder,6,3)=longTermHolder(j+moverAll,6);
%                     cellId(newCellAdder,7,3)=longTermHolder(j+moverAll,7);
%                     cellId(newCellAdder,8,3)=longTermHolder(j+moverAll,8);
%                     cellId(newCellAdder,9,3)=cellId(i,9,1);
%                     tracked=tracked+1;
%                     longTermHolder(j+moverAll,9)=1;
%                     newCellAdder=newCellAdder+1;
%                 end
%            end
%         end 
%     end
% end
% end
% found=0;
% for k=1:cellPerTime1(3)
%     if longTermHolder(k+moverAll,9)==0
%        cellId(newCellAdder,1,3)=longTermHolder(k+moverAll,1);
%        cellId(newCellAdder,2,3)=longTermHolder(k+moverAll,2);
%        cellId(newCellAdder,3,3)=longTermHolder(k+moverAll,3);
%        cellId(newCellAdder,4,3)=longTermHolder(k+moverAll,4);
%        cellId(newCellAdder,5,3)=longTermHolder(k+moverAll,5);
%        cellId(newCellAdder,6,3)=longTermHolder(k+moverAll,6);
%        cellId(newCellAdder,7,3)=longTermHolder(k+moverAll,7);
%        cellId(newCellAdder,8,3)=longTermHolder(k+moverAll,8);
%        cellId(newCellAdder,9,3)=cellCounter;
%        cellCounter=cellCounter+1;
%        found=found+1;
%        newCellAdder=newCellAdder+1;
%     end
%     
% end



% 
% 
% Image1Path = '/Users/Arbuckle/Desktop/Research/Images/s_C003T179.tif';
% image1Preload=imread(Image1Path);
% image1=imadjust(image1Preload);
% 
% Image2Path = '/Users/Arbuckle/Desktop/Research/Images/s_C003T180.tif';
% image2Preload=imread(Image2Path);
% image2=imadjust(image2Preload);

% 

 %figure,imshow(imageArray, []);title('Slide1 blobs');
 %hold on;
 %plot(cellId(:,1,2),cellId(:,2,2),'r+','MarkerSize',20,'LineWidth',1);
 %text(cellId(:,1,2),cellId(:,2,2),num2str(cellId(:,9,1)),'Color','r');
 %hold off;
filePattern = fullfile(myFolder, 's_C003*.tif');
jpegFiles = dir(filePattern);
for l = 1:2%length(jpegFiles)
  baseFileName = jpegFiles(l).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray = imread(fullFileName);
  [NewTest, centerholder, NewBW]=individualPhotoChecker(imageArray);
   counter=l;
 helper=int2str(counter);
 imshow(NewTest, []);title(counter);
 hold on;
 plot(cellId(:,1,l),cellId(:,2,l),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,l),cellId(:,2,l),num2str(cellId(:,9,l)),'Color','r');
 hold off;
 im=NewTest;
 process=strcat('TrackedImageImage',helper);
 processed=strcat(process,'.tiff');
 string='/Users/Arbuckle/Desktop/Research/Processed_Images/';
 WritePath=strcat(string,processed );
 fprintf(1,'Now writing %s\n',WritePath);
 hold on;
 plot(cellId(:,1,l),cellId(:,2,l),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,l),cellId(:,2,l),num2str(cellId(:,9,l)),'Color','r');
 hold off;
 f=getframe(gca);
 im=frame2im(f);
 imwrite(im,WritePath);
end 
% 
% figure,imshow(image2, []);title('Slide2 blobs');
% hold on;
% plot(cellId(:,1,2),cellId(:,2,2),'r+','MarkerSize',20,'LineWidth',1);
% text(cellId(:,1,2),cellId(:,2,2),num2str(cellId(:,9,2)),'Color','r');
% hold off;
% 
% figure,imshow(NewTest, []);title('Slide3 blobs');
% hold on;
% plot(cellId(:,1,3),cellId(:,2,3),'r+','MarkerSize',20,'LineWidth',1);
% text(cellId(:,1,3),cellId(:,2,3),num2str(cellId(:,9,3)),'Color','r');
% hold off;







% for i=1:cellPerTime1(2)
%      cellId(i,1,2)=longTermHolder(mover+i,1);
%      cellId(i,2,2)=longTermHolder(mover+i,2);
%      cellId(i,3,2)=longTermHolder(mover+i,3);
%      cellId(i,4,2)=longTermHolder(mover+i,4);
%      cellId(i,5,2)=longTermHolder(mover+i,5);
%      cellId(i,6,2)=longTermHolder(mover+i,6);
%      cellId(i,7,2)=longTermHolder(mover+i,7);
%      cellId(i,8,2)=longTermHolder(mover+i,8);
% end

    
    