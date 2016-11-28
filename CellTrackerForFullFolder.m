function[cellId,Iterator]=CellTrackerForFullFolder(cellPerTime1,longTermHolder,myFolder,RunInfo,X,WritePath)
cellId=zeros(1,1,1,'double');
%%WritePath='/home/exx/Desktop/Processed Images/';
%WriteString='/Users/codyarbuckle/Desktop/Processed Images';
WriteString=WritePath;
h=0;
similar=0;
tracked=0;
LongTracker=longTermHolder;
if length(cellPerTime1)<1
     cellId(1,1,1)=0;
     cellId(1,2,1)=0;
     cellId(1,3,1)=0;
     cellId(1,4,1)=0;
     cellId(1,5,1)=0;
     cellId(1,6,1)=0;
     cellId(1,7,1)=0;
     cellId(1,8,1)=0;
     cellId(1,9,1)=0;
     cellId(1,10,1)=0;
     cellId(1,11,1)=0;
     cellId(1,12,1)=0;
     cellId(1,13,1)=0;
     cellId(1,14,1)=0;
end

if length(cellPerTime1)>1
%initalize column to track if longterm main record has been associated with
%track
for r=1:length(longTermHolder)
    longTermHolder(r,13)=0;
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
     cellId(t,10,1)=0;
     cellId(t,11,1)=longTermHolder(t,9);
     cellId(t,12,1)=longTermHolder(t,10);
     cellId(t,13,1)=longTermHolder(t,11);
     cellId(t,14,1)=longTermHolder(t,12);
     cellCounter=cellCounter+1;
     longTermHolder(t,13)=1;
end
layers=1;%set layer to 1 becuase first layer of cube has been created 
mover=0;%create window for each round of detection
found=0;%Track number of new tracks created
for w=1:(length(cellPerTime1)-1)
    %Iterate through every timestamp
    nextlayer=layers+1;

    %add next layer of cube
    LayerDensity=cellPerTime1(layers);%Get number of cells detected 
    mover=mover+LayerDensity;%Used to Shift window of cellPerTime to next 
    newCellAdder=1;%Create row incremeter for each layer
    for i=1:size(cellId,1)
        if i<=(cellPerTime1(layers))
            g=size(cellId,3);
        storedX=cellId(i,1,g);
        storedY=cellId(i,2,g);
        %Grab x and y stored in current layer of cube 
     for j=1:cellPerTime1(nextlayer)
         if cellPerTime1(nextlayer)>1
            checkingX=longTermHolder(j+mover,1);
            checkingY=longTermHolder(j+mover,2);
            Xdist=((storedX-checkingX).^2);
            Ydist=((storedY-checkingY).^2);
            Dist=(Xdist+Ydist);
            %Check timestamp for cell in area surounding tracked cell 
        if Dist<25
                LongDiff=(cellId(i,6,layers)/(longTermHolder(j+mover,6)));
                ShortDiff=(cellId(i,7,layers)/longTermHolder(j+mover,7));
                DimDiff=abs((LongDiff+ShortDiff));
                %if DimDiff<15
                    if(longTermHolder(j+mover,13)>=0)
                        cellId(newCellAdder,1,nextlayer)=longTermHolder(j+mover,1);
                        cellId(newCellAdder,2,nextlayer)=longTermHolder(j+mover,2);
                        cellId(newCellAdder,3,nextlayer)=longTermHolder(j+mover,3);
                        cellId(newCellAdder,4,nextlayer)=longTermHolder(j+mover,4);
                        cellId(newCellAdder,5,nextlayer)=longTermHolder(j+mover,5);
                        cellId(newCellAdder,6,nextlayer)=longTermHolder(j+mover,6);
                        cellId(newCellAdder,7,nextlayer)=longTermHolder(j+mover,7);
                        cellId(newCellAdder,8,nextlayer)=longTermHolder(j+mover,8);
                        cellId(newCellAdder,9,nextlayer)=cellId(i,9,layers);
                        cellId(newCellAdder,10,nextlayer)=Dist;
                        cellId(newCellAdder,11,nextlayer)=longTermHolder(j+mover,9);
                        cellId(newCellAdder,12,nextlayer)=longTermHolder(j+mover,10);
                        cellId(newCellAdder,13,nextlayer)=longTermHolder(j+mover,11);
                        cellId(newCellAdder,14,nextlayer)=longTermHolder(j+mover,12);
                        tracked=tracked+1;
                        longTermHolder(j+mover,9)=1;
                        newCellAdder=newCellAdder+1;
                    end
                end
        end 
         end
     end 
    for l=1:cellPerTime1(nextlayer)
        if cellPerTime1(nextlayer)>1
        if longTermHolder(l+mover,13)==5
            cellId(newCellAdder,1,nextlayer)=longTermHolder(l+mover,1);
            cellId(newCellAdder,2,nextlayer)=longTermHolder(l+mover,2);
            cellId(newCellAdder,3,nextlayer)=longTermHolder(l+mover,3);
            cellId(newCellAdder,4,nextlayer)=longTermHolder(l+mover,4);
            cellId(newCellAdder,5,nextlayer)=longTermHolder(l+mover,5);
            cellId(newCellAdder,6,nextlayer)=longTermHolder(l+mover,6);
            cellId(newCellAdder,7,nextlayer)=longTermHolder(l+mover,7);
            cellId(newCellAdder,8,nextlayer)=longTermHolder(l+mover,8);
            cellId(newCellAdder,9,nextlayer)=cellCounter;
            cellId(newCellAdder,10,nextlayer)=0;
            cellId(newCellAdder,11,nextlayer)=longTermHolder(l+mover,9);
            cellId(newCellAdder,12,nextlayer)=longTermHolder(l+mover,10);
            cellId(newCellAdder,13,nextlayer)=longTermHolder(l+mover,11);
            cellId(newCellAdder,14,nextlayer)=longTermHolder(j+mover,12);
            cellCounter=cellCounter+1;
            longTermHolder(l+mover,13)=1;
            found=found+1;
            newCellAdder=newCellAdder+1;
           end
        end 
    end
    layers=nextlayer;
end 
    end
end

if X==1
    filePattern = fullfile(myFolder, 's_C003*.tif');
jpegFiles = dir(filePattern);
x=length(jpegFiles)
for y = 1:length(jpegFiles)
  baseFileName = jpegFiles(y).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray = imread(fullFileName);
  [NewTest, centerholder, NewBW]=individualPhotoChecker(imageArray);
   counter=y;
 helper=int2str(counter);
 imshow(NewTest, []);title(counter);
 
 hold on;
 if y<=size(cellId,3)
 plot(cellId(:,1,y),cellId(:,2,y),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,y),cellId(:,2,y),num2str(cellId(:,9,y)),'Color','r');
 end
 hold off;
 im=NewTest;
 process=strcat('TrackedImageImage',helper);
 processed=strcat(process,'.tiff');
 %string='/home/exx/Desktop/Processed Images/';
 string=WriteString;
 string=strcat(string,RunInfo);
 WritePath=strcat(string,processed );
 fprintf(1,'Now writing %s\n',WritePath);
 hold on;
 if y<=size(cellId,3)
 plot(cellId(:,1,y),cellId(:,2,y),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,y),cellId(:,2,y),num2str(cellId(:,9,y)),'Color','r');
 hold off;
 end
 f=getframe(gca);
 im=frame2im(f);
 imwrite(im,WritePath);
 end 
end  
 
if X==2 

filePattern = fullfile(myFolder, 's_C003*.tif');
jpegFiles = dir(filePattern);
filePatternCRAC = fullfile(myFolder, 's_C002*.tif');
jpegFilesCRAC = dir(filePatternCRAC);
x=length(jpegFiles);
for y = 1:length(jpegFiles)
 
    baseFileName = jpegFiles(y).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray = imread(fullFileName);
   [NewTest, centerholder, NewBW]=individualPhotoChecker(imageArray);
  
    baseFileNameCRAC = jpegFilesCRAC(y).name;
  fullFileNameCRAC = fullfile(myFolder, baseFileNameCRAC);
  fprintf(1, 'Now reading %s\n', fullFileNameCRAC);
  imageArrayCRAC = imread(fullFileNameCRAC);
[NewTestCRAC, centerholderCRAC, NewBWCRAC]=individualPhotoChecker(imageArrayCRAC);
 blackImage=zeros(size(NewTestCRAC),'uint16');
 rgbImage=cat(3,blackImage,NewTestCRAC,blackImage);  
   counter=y;
  
 helper=int2str(counter);
 hold on;
 imshow(NewTest)
 hImg=imshow(rgbImage); set (hImg,'AlphaData',0.6);title(counter);
if y<=size(cellId,3)
 plot(cellId(:,1,y),cellId(:,2,y),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,y),cellId(:,2,y),num2str(cellId(:,9,y)),'Color','r');
end
 hold off;
 im=NewTest;
 process=strcat('TrackedImageImageCRAC23',helper);
 processed=strcat(process,'.tiff');
 %%string='/home/exx/Desktop/Processed Images/';
 string=WriteString;
 string=strcat(string,RunInfo);
 WritePath=strcat(string,processed );
 fprintf(1,'Now writing %s\n',WritePath);
 hold on;
if y<=size(cellId,3)
 plot(cellId(:,1,y),cellId(:,2,y),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,y),cellId(:,2,y),num2str(cellId(:,9,y)),'Color','r');
end
 hold off;
 f=getframe(gca);
 im=frame2im(f);
 imwrite(im,WritePath);
end 
end 


if X==3 

filePattern = fullfile(myFolder, 's_C003*.tif');
jpegFiles = dir(filePattern);
filePatternCRAC = fullfile(myFolder, 's_C001*.tif');
jpegFilesCRAC = dir(filePatternCRAC);
x=length(jpegFiles);
for y = 1:3
 
    baseFileName = jpegFiles(y).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray = imread(fullFileName);
   [NewTest, centerholder, NewBW]=individualPhotoChecker(imageArray);
  
    baseFileNameCRAC = jpegFilesCRAC(y).name;
  fullFileNameCRAC = fullfile(myFolder, baseFileNameCRAC);
  fprintf(1, 'Now reading %s\n', fullFileNameCRAC);
  imageArrayCRAC = imread(fullFileNameCRAC);
[NewTestCRAC, centerholderCRAC, NewBWCRAC]=individualPhotoChecker(imageArrayCRAC);
 blackImage=zeros(size(NewTestCRAC),'uint16');
 rgbImage=cat(3,NewTestCRAC,blackImage,blackImage);  
   counter=y; 
 helper=int2str(counter);
 hold on;
 imshow(NewTest)
 hImg=imshow(rgbImage); set (hImg,'AlphaData',0.6);title(counter);
if 1==1
 plot(cellId(:,1,1),cellId(:,2,1),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,1),cellId(:,2,1),num2str(cellId(:,9,1)),'Color','r');
end
 hold off;
 im=NewTest;
 process=strcat('TrackedImageImageCRAC13',helper);
 processed=strcat(process,'.tiff');
 %%string='/home/exx/Desktop/Processed Images/';
 string=WriteString;
 string=strcat(string,RunInfo);
 WritePath=strcat(string,processed );
 fprintf(1,'Now writing %s\n',WritePath);
 hold on;
if y<=size(cellId,3)
 plot(cellId(:,1,1),cellId(:,2,1),'r+','MarkerSize',20,'LineWidth',1);
 text(cellId(:,1,1),cellId(:,2,1),num2str(cellId(:,9,1)),'Color','r');
end
 hold off;
 f=getframe(gca);
 im=frame2im(f);
 imwrite(im,WritePath);
end 
end 

    
    


Iterator=1;
end 
    
    