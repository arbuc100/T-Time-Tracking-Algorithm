%topfolder='/home/exx/Desktop/Data from Milton/';
topfolder='/Users/codyarbuckle/Desktop/Data From Milton/';
allSubFolders=genpath(topfolder);
remain=allSubFolders;
listofFolderNames={};
%token='/home/exx/Desktop/Data from Milton/';
token='/Users/codyarbuckle/Desktop/Data From Milton/';
IteratorCount=0;

%topfolderProcessed='/home/exx/Desktop/Processed Images/';
topfolderProcessed='Users/codyarbuckle/Desktop/Processed Images/';
%WritePath='/home/exx/Desktop/Processed Images/';
WritePath='/Users/codyarbuckle/Desktop/Processed Images';
allSubFoldersProcessed=genpath(topfolderProcessed);
remainProcessed=allSubFoldersProcessed;
listofFolderNamesProcessed={};
AlreadyProcessed=0;
Backto3DPhase1=zeros(1,1,'double');
Backto3DPhase2=zeros(1,1,'double');
Backto3D=zeros(1,1,'double');


while true 
    [singleSubFolder,remain]= strtok(remain,':');
    if isempty(singleSubFolder)
        break;
    end
    listofFolderNames=[listofFolderNames singleSubFolder];
    s=singleSubFolder;
    stringlength=length(s);
    %name=s(35:stringlength);
    name=s(45:stringlength);
    name=strcat(name,'/');
    %fprintf('test2 %s\n',name);
    
end
numberofFolders=length(listofFolderNames);

while true 
    [singleSubFolderProcessed,remainProcessed]= strtok(remainProcessed,':');
    if isempty(singleSubFolderProcessed)
        break;
    end
    listofFolderNamesProcessed=[listofFolderNamesProcessed singleSubFolderProcessed];
    sProcessed=singleSubFolderProcessed;
    stringlengthProcessed=length(sProcessed);
    %nameProcessed=sProcessed(35:stringlengthProcessed);
    nameProcessed=sProcessed(45:stringlengthProcessed);
    nameProcessed=strcat(nameProcessed,'/');
    %fprintf('test2 %s\n',name);
    
end
numberofFoldersProcessed=length(listofFolderNamesProcessed);

    

for k =1:numberofFolders;
    thisFolder=listofFolderNames{k};
    stringlengthChecker=length(thisFolder);
    if stringlengthChecker>45
    nameThisFolder=thisFolder(45:stringlengthChecker);
    for j=1:numberofFoldersProcessed
       thisFolderProcessed=listofFolderNamesProcessed{j};
       stringlengthCheckerProcessed=length(thisFolderProcessed);
       if stringlengthCheckerProcessed>45
       nameThisFolderProcessed=(45:stringlengthCheckerProcessed);
       samefolder=strcmp(nameThisFolder,nameThisFolderProcessed);
       if samefolder==1
           AlreadyProcess=1;
       end 
       end 
    end
    if AlreadyProcessed==0 
    %fprintf('Processing folder %s\n',thisFolder);
    s=thisFolder;
    stringlength=length(s);
    name=s(35:stringlength);
    name=s(45:stringlength);
    RunInfo=strcat(name,'/');
    %fprintf('Writing Folder %s\n',RunInfo);
    filePattern=sprintf('%s/*.tif',thisFolder);
    baseFileNames=dir(filePattern);
    filePattern=sprintf('%s/*.tif',thisFolder);
    baseFileNames=[baseFileNames;dir(filePattern)];
    
    numberOfImageFiles=length(baseFileNames);
    TopPathForOutput=strcat(topfolder,'Output');
    if numberOfImageFiles >=1 
        for f=1:numberOfImageFiles
            fullFileName=fullfile(thisFolder,baseFileNames(f).name);
            %fprintf(' Processing image file %s\n',fullFileName);
        end
    end
    %fprintf(' Folder %s has no image files in it.\n',thisFolder);
   [cellPerTime1,longTermHolder,cellPerTime1Phase2,longTermHolderPhase2,cellPerTime1Phase1,longTermHolderPhase1]=FullFolderBatchRunner(thisFolder,RunInfo,TopPathForOutput,WritePath);
   X=1;
   [CellId,Iterator]=CellTrackerForFullFolder(cellPerTime1,longTermHolder,thisFolder,RunInfo,X,WritePath);
   X=2;
   [CellIdPhase2,IteratorPhase2]=CellTrackerForFullFolder(cellPerTime1Phase2,longTermHolderPhase2,thisFolder,RunInfo,X,WritePath);
   IteratorCount=IteratorCount+Iterator;
   X=3;
   [CellIdPhase1,IteratorPhase1]=CellTrackerForFullFolder(cellPerTime1Phase1,longTermHolderPhase1,thisFolder,RunInfo,X,WritePath);
   X=1;
  %{ 
[Backto3D]=MatrixReformater(CellId,cellPerTime1,k,RunInfo,X,WritePath);
   X=2;
   [Backto3DPhase2]=MatrixReformater(CellIdPhase2,cellPerTime1Phase2,k,RunInfo,X,WritePath);
   X=3;
   [Backto3DPhase1]=MatrixReformater(CellIdPhase1,cellPerTime1Phase1,k,RunInfo,X,WritePath);
   [AssociatePhases]=PhaseAssociator(Backto3DPhase1,Backto3DPhase2,cellPerTime1Phase1,cellPerTime1Phase2,WritePath,RunInfo);
 %}  
 end 
    end
end 

IteratorCount=int2str(IteratorCount);
fprintf('Function Ran for %s Iteratoins\n',IteratorCount);



    
    
    
    

