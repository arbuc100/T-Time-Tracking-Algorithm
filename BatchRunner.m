longTermHolder=zeros(1,4,'double');
longTermTracker1=0;
timeStamp=1;
cellPerTime1=zeros(1,1,'double');
myFolder = '/Users/Arbuckle/Desktop/Research/60x RFP-V5-GCamp6f_16.oif.files';
%myFolder='/Volumes/MLATLAB/Data from Milton/14-04-17/60x RFP-V5-GCamp6f_16.oif.files';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, 's_C003*.tif');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray = imread(fullFileName);
  
 [NewTest, centerholder, NewBW]=individualPhotoChecker(imageArray);
 holder=size(centerholder,1);
 cellPerTime1(timeStamp)=holder;
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