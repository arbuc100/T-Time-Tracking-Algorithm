longTermHolder=zeros(1,4,'double');
longTermTracker1=0;
timeStamp=1;
cellPerTime1=zeros(1,1,'double');
cellPerTimeCRAC=zeros(1,1,'double');
myFolder='/home/exx/Desktop/Data from Milton/14-04-17/60x RFP-V5-GCamp6f_16.oif.files';
RunInfo='14-04-17/60x RFP-V5-GCamp6f_16.oif.files/';
mkdir('/home/exx/Desktop/Processed Images GPU/','14-04-17/60x RFP-V5-GCamp6f_16.oif.files');
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
  %get image path from phase 2
filePatternCRAC = fullfile(myFolder, 's_C002*.tif');
jpegFilesCRAC = dir(filePatternCRAC);

%get image path from phase 3 
filePattern = fullfile(myFolder, 's_C003*.tif');
jpegFiles = dir(filePattern);


for l = 1: length(jpegFiles)
  %get images from phase 2
  baseFileNameCRAC = jpegFilesCRAC(l).name;
  fullFileNameCRAC = fullfile(myFolder, baseFileNameCRAC);
  fprintf(1, 'Now reading %s\n', fullFileNameCRAC);
  imageArrayPRECRAC = imread(fullFileNameCRAC);
  imageArrayCRAC=gpuArray(imageArrayPRECRAC); 
    
  % get images from phase 3   
  baseFileName = jpegFiles(l).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imagePREArray = imread(fullFileName);
  imageArray=gpuArray(imagePREArray);
  
  %enhance images from phase 2 
  helperCRAC=int2str(l);
  imageletterCRAC=strcat('EnhancedImagePhase2 - ',helperCRAC);
 [NewTestCRAC, centerholderCRAC, NewBWCRAC]=individualPhotoCheckerGPU(imageArrayCRAC);
 holderCRAC=size(centerholderCRAC,1);
 cellPerTimeCRAC(timeStamp)=holderCRAC;
 ProcessedImageBaseFolderPath='/home/exx/Desktop/Processed Images/';
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteCracImages=strcat(ProcessedImageFolderPath,imageletterCRAC);
 WritePathCRAC=strcat(WriteCracImages,'.tiff');
 %enhacne phase 3 images
  helperPhase3=int2str(l);
  imageletterPhase3=strcat('EnhancedImagePhase3 - ',helperPhase3);
 [NewTest, centerholder, NewBW]=individualPhotoCheckerGPU(imageArray);
 holder=size(centerholder,1);
 cellPerTime1(timeStamp)=holder;
 ProcessedImageBaseFolderPath='/home/exx/Desktop/Processed Images/';
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteImages=strcat(ProcessedImageFolderPath,imageletterPhase3);
 WritePath=strcat(WriteImages,'.tiff');
 
 gpuTestCRAC=gather(NewTestCRAC);
 %write phase 2 images
 fprintf(1,'Now Writing %s\n',WritePathCRAC);
 imwrite(gpuTestCRAC,WritePathCRAC);
 
 gpuTest=gather(NewTest);
  %write phase 3 images
 fprintf(1,'Now Writing %s\n',WritePath);
 imwrite(gpuTest,WritePath);
 
 %turn phase 2 images to greenscale
 blackImage=zeros(size(NewTestCRAC),'uint16');
 rgbImage=cat(3,blackImage,NewTestCRAC,blackImage);
 
 %show each image
 imshow(rgbImage);
 imshow(NewTest);
 
  %write overlayed image
  helperOverlay=int2str(l);
  imageletterOverlay=strcat('EnhancedImageOverlay - ',helperOverlay);
 ProcessedImageBaseFolderPath='/home/exx/Desktop/Processed Images/';
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteOverlayImages=strcat(ProcessedImageFolderPath,imageletterOverlay);
 WritePathOverlay=strcat(WriteOverlayImages,'.tiff');
 
  fprintf(1,'Now Writing %s\n',WritePathOverlay);
 %overlay Image
 hold on;
 imshow(gpuTest)
 hImg=imshow(rgbImage); set (hImg,'AlphaData',0.6);
 hold off;
 f=getframe(gca);
 im=frame2im(f);
 imwrite(im,WritePathOverlay);

 

 
 for k=1:holder
    longTermHolder((longTermTracker1+k),1)=centerholder(k,1);
    longTermHolder((longTermTracker1+k),2)=centerholder(k,2);
    longTermHolder((longTermTracker1+k),3)=centerholder(k,3);
    longTermHolder((longTermTracker1+k),4)=centerholder(k,4);
    longTermHolder((longTermTracker1+k),5)=centerholder(k,5);
    longTermHolder((longTermTracker1+k),6)=centerholder(k,6);
    longTermHolder((longTermTracker1+k),7)=centerholder(k,7);
    longTermHolder((longTermTracker1+k),8)=timeStamp; 
 end 
longTermTracker1=longTermTracker1+holder;
timeStamp=timeStamp+1;
end