function[Backto3D]=MatrixReformater(CellId,cellPerTime1,k,RunInfo,X,WritePath)
holder=0;
y=0;
%WritePath='/home/exx/Desktop/Processed Images/';
%WritePath='/Users/codyarbuckle/Desktop/Processed Images';
Backto3D=zeros(1,1,'double');
if ~isempty(cellPerTime1)
for p=1:length(cellPerTime1)
    for y=1:cellPerTime1(p)
        if size(CellId,3)>=p
        Backto3D(y+holder,1)=CellId(y,1,p);
        Backto3D(y+holder,2)=CellId(y,2,p);
        Backto3D(y+holder,3)=CellId(y,3,p);
        Backto3D(y+holder,4)=CellId(y,4,p);
        Backto3D(y+holder,5)=CellId(y,5,p);
        Backto3D(y+holder,6)=CellId(y,6,p);
        Backto3D(y+holder,7)=CellId(y,7,p);
        Backto3D(y+holder,8)=CellId(y,8,p);
        Backto3D(y+holder,9)=CellId(y,9,p);
        Backto3D(y+holder,10)=CellId(y,10,p);
        Backto3D(y+holder,11)=CellId(y,11,p);
        Backto3D(y+holder,12)=CellId(y,12,p);
        Backto3D(y+holder,13)=CellId(y,13,p);
        Backto3D(y+holder,14)=CellId(y,14,p);
        end
    end 
    holder=holder+1;
       
        Backto3D(y+holder,1)=0;
        Backto3D(y+holder,2)=0;
        Backto3D(y+holder,3)=0;
        Backto3D(y+holder,4)=0;
        Backto3D(y+holder,5)=0;
        Backto3D(y+holder,6)=0;
        Backto3D(y+holder,7)=0;
        Backto3D(y+holder,8)=0;
        Backto3D(y+holder,9)=0;
        Backto3D(y+holder,10)=0;
        Backto3D(y+holder,11)=0;
        Backto3D(y+holder,12)=0;
        Backto3D(y+holder,13)=0;
        Backto3D(y+holder,14)=0;
    
    holder=cellPerTime1(p)+holder;
end 
if X==1
k=int2str(k);
 imageletterOverlay=strcat('2D Data- ',k);
 ProcessedImageBaseFolderPath=WritePath;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteOverlayImages=strcat(ProcessedImageFolderPath,imageletterOverlay);
 WritePathOverlay=strcat(WriteOverlayImages,'.csv');
csvwrite(WritePathOverlay,Backto3D);
fprintf('Now Writing Tracked Cell Data for %s\n',WritePathOverlay);
end 
if X==2
k=int2str(k);
 imageletterOverlay=strcat('2D Data Phase 23 - ',k);
 ProcessedImageBaseFolderPath=WritePath;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteOverlayImages=strcat(ProcessedImageFolderPath,imageletterOverlay);
 WritePathOverlay=strcat(WriteOverlayImages,'.csv');
csvwrite(WritePathOverlay,Backto3D);
fprintf('Now Writing Tracked Cell Data for %s\n',WritePathOverlay);
end 
if X==3
k=int2str(k);
 imageletterOverlay=strcat('2D Data Phase 13 - ',k);
 ProcessedImageBaseFolderPath=WritePath;
 %ProcessedImageBaseFolderPath=TopPathForOutput;
 ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
 WriteOverlayImages=strcat(ProcessedImageFolderPath,imageletterOverlay);
 WritePathOverlay=strcat(WriteOverlayImages,'.csv');
csvwrite(WritePathOverlay,Backto3D);
fprintf('Now Writing Tracked Cell Data for %s\n',WritePathOverlay);
end 
end
end 