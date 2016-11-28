function [cellPerTime1,longTermHolder,cellPerTime1Phase2,longTermHolderPhase2,cellPerTime1Phase1,longTermHolderPhase1]=FullFolderBatchRunner(myFolder,RunInfo,TopPathForOutput,WritePath)
longTermHolder=zeros(1,4,'double');
longTermHolderPhase1=zeros(1,4,'double');
longTermHolderPhase2=zeros(1,4,'double');
longTermTracker1=0;
longTermTracker1Phase1=0;
longTermTracker1Phase2=0;
timeStamp=1;
timeStampPhase1=1;
timeStampPhase2=1;
Iterator=0;
cellPerTime1=zeros(1,1,'double');
cellPerTime1Phase1=zeros(1,1,'double');
cellPerTime1Phase2=zeros(1,1,'double');
%WriteString='/home/exx/Desktop/Processed Images';
%WriteString='/Users/codyarbuckle/Desktop/Processed Images';
WriteString=WritePath;
%myFolder='/home/exx/Desktop/Data from Milton/14-04-17/60x RFP-V5-GCamp6f_16.oif.files';
%RunInfo='14-04-17/60x RFP-V5-GCamp6f_16.oif.files/';
mkdir(WriteString,RunInfo);
k=0;
r=0;
RunInfo=strcat(RunInfo,'/');
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
  %get image path from phase 1
filePatternPhase1 = fullfile(myFolder, 's_C001*.tif');
jpegFilesPhase1 = dir(filePatternPhase1);

  %get image path from phase 2
filePatternPhase2 = fullfile(myFolder, 's_C002*.tif');
jpegFilesPhase2 = dir(filePatternPhase2);

%get image path from phase 3 
filePattern = fullfile(myFolder, 's_C003*.tif');
jpegFiles = dir(filePattern);


for l = 1: length(jpegFiles)
    %get images from phase 1
  
  baseFileNamePhase1 = jpegFilesPhase1(l).name;
  fullFileNamePhase1 = fullfile(myFolder, baseFileNamePhase1);
  fprintf(1, 'Now reading %s\n', fullFileNamePhase1);
  imageArrayPhase1 = imread(fullFileNamePhase1);
    
  %get images from phase 2
  
  baseFileNamePhase2 = jpegFilesPhase2(l).name;
  fullFileNamePhase2 = fullfile(myFolder, baseFileNamePhase2);
  fprintf(1, 'Now reading %s\n', fullFileNamePhase2);
  imageArrayPhase2 = imread(fullFileNamePhase2);
    
  % get images from phase 3   
  baseFileName = jpegFiles(l).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray = imread(fullFileName);
    
  %enhance images from phase 1 
  helperPhase1=int2str(l);
  imageletterPhase1=strcat('EnhancedImagePhase1 - ',helperPhase1);
 [NewTestPhase1, centerholderPhase1, NewBWPhase1]=individualPhotoChecker(imageArrayPhase1);
 holderPhase1=size(centerholderPhase1,1);
 cellPerTimePhase1(timeStamp)=holderPhase1;
 ProcessedImageBaseFolderPath=WriteString;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WritePhase1Images=strcat(ProcessedImageFolderPath,imageletterPhase1);
 WritePathPhase1=strcat(WritePhase1Images,'.tiff');
  
  %enhance images from phase 2 
  helperPhase2=int2str(l);
  imageletterPhase2=strcat('EnhancedImagePhase2 - ',helperPhase2);
 [NewTestPhase2, centerholderPhase2, NewBWPhase2]=individualPhotoChecker(imageArrayPhase2);
 holderPhase2=size(centerholderPhase2,1);
 cellPerTimePhase2(timeStamp)=holderPhase2;
 ProcessedImageBaseFolderPath=WriteString;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WritePhase2Images=strcat(ProcessedImageFolderPath,imageletterPhase2);
 WritePathPhase2=strcat(WritePhase2Images,'.tiff');
 
 %enhance phase 3 images
  helperPhase3=int2str(l);
  imageletterPhase3=strcat('EnhancedImagePhase3 - ',helperPhase3);
 [NewTest, centerholder, NewBW]=individualPhotoChecker(imageArray);
 holder=size(centerholder,1);
 cellPerTime1(timeStamp)=holder;
 ProcessedImageBaseFolderPath=WriteString;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteImages=strcat(ProcessedImageFolderPath,imageletterPhase3);
 WritePath=strcat(WriteImages,'.tiff');
 
  %write phase 1 images
 fprintf(1,'Now Writing %s\n',WritePathPhase1);
 imwrite(NewTestPhase2,WritePathPhase1);
 
 %write phase 2 images
 fprintf(1,'Now Writing %s\n',WritePathPhase2);
 imwrite(NewTestPhase2,WritePathPhase2);
 
  %write phase 3 images
 fprintf(1,'Now Writing %s\n',WritePath);
 imwrite(NewTest,WritePath);
 
 
 %Overlay Phase 2-3
 %turn phase 2 images to greenscale
 blackImage=zeros(size(NewTestPhase2),'uint16');
 rgbImage=cat(3,blackImage,NewTestPhase2,blackImage);
 
 %show each image
 imshow(rgbImage);
 imshow(NewTest);
 
  %write overlayed image
 helperOverlay=int2str(l);
 imageletterOverlay=strcat('EnhancedImageOverlay23 - ',helperOverlay);
 ProcessedImageBaseFolderPath=WriteString;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteOverlayImages=strcat(ProcessedImageFolderPath,imageletterOverlay);
 WritePathOverlay=strcat(WriteOverlayImages,'.tiff');
 
 fprintf(1,'Now Writing %s\n',WritePathOverlay);
 %overlay Image
 hold on;
 imshow(NewTest)
 hImg=imshow(rgbImage); set (hImg,'AlphaData',0.6);
 hold off;
 f=getframe(gca);
 im=frame2im(f);
 imwrite(im,WritePathOverlay);
 
 NewTestPhase2=(NewTest*0.25)+(NewTestPhase2*0.75);
 
 
 [NewTestPhase2, centerholderPhase2, NewBWPhase2]=individualPhotoChecker(NewTestPhase2);
 holderPhase2=size(centerholderPhase2,1);
 cellPerTime1Phase2(timeStampPhase2)=holderPhase2;

 %Overlay Phase 1-3
 %turn phase 2 images to greenscale
 blackImage=zeros(size(NewTestPhase1),'uint16');
 rgbImage=cat(3,NewTestPhase1,blackImage,blackImage);
 
 %show each image
 imshow(rgbImage);
 imshow(NewTest);
 
  %write overlayed image
 helperOverlay=int2str(l);
 imageletterOverlay=strcat('EnhancedImageOverlay13 - ',helperOverlay);
 ProcessedImageBaseFolderPath=WriteString;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteOverlayImages=strcat(ProcessedImageFolderPath,imageletterOverlay);
 WritePathOverlay=strcat(WriteOverlayImages,'.tiff');
 
 fprintf(1,'Now Writing %s\n',WritePathOverlay);
 %overlay Image
 hold on;
 imshow(NewTest)
 hImg=imshow(rgbImage); set (hImg,'AlphaData',0.6);
 hold off;
 f=getframe(gca);
 im=frame2im(f);
 imwrite(im,WritePathOverlay);
 
 NewTestPhase1=(NewTest*0.25)+(NewTestPhase1*0.75);
 
 
 [NewTestPhase1, centerholderPhase1, NewBWPhase1]=individualPhotoChecker(NewTestPhase1);
 holderPhase1=size(centerholderPhase1,1);
 cellPerTime1Phase1(timeStampPhase1)=holderPhase1;
 
 for k=1:holder
     
    longTermHolder((longTermTracker1+k),1)=centerholder(k,1);
    longTermHolder((longTermTracker1+k),2)=centerholder(k,2);
    longTermHolder((longTermTracker1+k),3)=centerholder(k,3);
    longTermHolder((longTermTracker1+k),4)=centerholder(k,4);
    longTermHolder((longTermTracker1+k),5)=centerholder(k,5);
    longTermHolder((longTermTracker1+k),6)=centerholder(k,6);
    longTermHolder((longTermTracker1+k),7)=centerholder(k,7);
    longTermHolder((longTermTracker1+k),8)=timeStamp; 
    longTermHolder((longTermTracker1+k),9)=centerholder(k,8);
    longTermHolder((longTermTracker1+k),10)=centerholder(k,9);
    longTermHolder((longTermTracker1+k),11)=centerholder(k,10);
    longTermHolder((longTermTracker1+k),12)=centerholder(k,11);
 end 
longTermTracker1=longTermTracker1+holder;
timeStamp=timeStamp+1;
if holderPhase2>1 
for r=1:holderPhase2

    longTermHolderPhase2((longTermTracker1Phase2+r),1)=centerholderPhase2(r,1);
    longTermHolderPhase2((longTermTracker1Phase2+r),2)=centerholderPhase2(r,2);
    longTermHolderPhase2((longTermTracker1Phase2+r),3)=centerholderPhase2(r,3);
    longTermHolderPhase2((longTermTracker1Phase2+r),4)=centerholderPhase2(r,4);
    longTermHolderPhase2((longTermTracker1Phase2+r),5)=centerholderPhase2(r,5);
    longTermHolderPhase2((longTermTracker1Phase2+r),6)=centerholderPhase2(r,6);
    longTermHolderPhase2((longTermTracker1Phase2+r),7)=centerholderPhase2(r,7);
    longTermHolderPhase2((longTermTracker1Phase2+r),8)=timeStampPhase2; 
    longTermHolderPhase2((longTermTracker1Phase2+r),9)=centerholderPhase2(r,8);
    longTermHolderPhase2((longTermTracker1Phase2+r),10)=centerholderPhase2(r,9);
    longTermHolderPhase2((longTermTracker1Phase2+r),11)=centerholderPhase2(r,10);
    longTermHolderPhase2((longTermTracker1Phase2+r),12)=centerholderPhase2(r,11);
end 
 longTermTracker1Phase2=longTermTracker1Phase2+holderPhase2;
 timeStampPhase2=timeStampPhase2+1;
end 

if holderPhase1>1 
for p=1:holderPhase1

    longTermHolderPhase1((longTermTracker1Phase1+p),1)=centerholderPhase1(p,1);
    longTermHolderPhase1((longTermTracker1Phase1+p),2)=centerholderPhase1(p,2);
    longTermHolderPhase1((longTermTracker1Phase1+p),3)=centerholderPhase1(p,3);
    longTermHolderPhase1((longTermTracker1Phase1+p),4)=centerholderPhase1(p,4);
    longTermHolderPhase1((longTermTracker1Phase1+p),5)=centerholderPhase1(p,5);
    longTermHolderPhase1((longTermTracker1Phase1+p),6)=centerholderPhase1(p,6);
    longTermHolderPhase1((longTermTracker1Phase1+p),7)=centerholderPhase1(p,7);
    longTermHolderPhase1((longTermTracker1Phase1+p),8)=timeStampPhase1; 
    longTermHolderPhase1((longTermTracker1Phase1+p),9)=centerholderPhase1(p,8);
    longTermHolderPhase1((longTermTracker1Phase1+p),10)=centerholderPhase1(p,9);
    longTermHolderPhase1((longTermTracker1Phase1+p),11)=centerholderPhase1(p,10);
    longTermHolderPhase1((longTermTracker1Phase1+p),12)=centerholderPhase1(p,11);
end 
 longTermTracker1Phase1=longTermTracker1Phase1+holderPhase1;
 timeStampPhase1=timeStampPhase1+1;
end 
end 




Iterator=1; 
end 