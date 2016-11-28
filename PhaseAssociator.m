function [AssociatePhases]=PhaseAssociator(Backto3DPhase1,Backto3DPhase2,cellPerTime1Phase1,cellPerTime1Phase2,WritePath,RunInfo)
AssociatePhases=zeros(1,14,'double');
holder=1;
Phase2Holder=0;
Phase1Holder=0;
for p=1:length(cellPerTime1Phase1)
    for q=1:length(cellPerTime1Phase2)
        for r=1:cellPerTime1Phase1(p)
            for t=1:cellPerTime1Phase1(q)
                Phase1X=Backto3DPhase1(Phase1Holder+r,1);
                Phase2X=Backto3DPhase2(Phase2Holder+t,1);
                Phase1Y=Backto3DPhase1(Phase1Holder+r,2);
                Phase2Y=Backto3DPhase2(Phase2Holder+t,2);
                Phase1TS=Backto3DPhase1(Phase1Holder+r,8);
                Phase2TS=Backto3DPhase2(Phase2Holder+t,8);
                Xdist=((Phase1X-Phase2X).^2);
                Ydist=((Phase1Y-Phase2Y).^2);
                Dist=((Xdist+Ydist).^(1/2));
                if Phase1TS==Phase2TS
                if Dist<10
                    AssociatePhases(holder,1:14)=Backto3DPhase2(Phase2Holder+t,1:14);
                    AssociatePhases(holder,15)=Backto3DPhase1(Phase1Holder+r,5);
                    AssociatePhases(holder,16)=Backto3DPhase1(Phase1Holder+r,13);
                    AssociatePhases(holder,17)=Backto3DPhase1(Phase1Holder+r,14);
                    AssociatePhases(holder,18)=(Backto3DPhase2(Phase2Holder+t,14)/Backto3DPhase1(Phase1Holder+r,14));
                    AssociatePhases(holder,19)=Dist;
                    holder=holder+1;
                end  
                end 
            end
            
        end
        if q==1
            Phase2Holder=0;
        end 
        if q>1
        Phase2Holder=Phase2Holder+cellPerTime1Phase2(q-1)+1;
        end
    end
        if p>1
        Phase1Holder=Phase1Holder+cellPerTime1Phase1(p-1)+1;
        end
 
end
Phase1Holder=Phase1Holder+cellPerTime1Phase1(p)+1;
Phase2Holder=Phase2Holder+cellPerTime1Phase2(q)+1;
 RunInfoLength=length(RunInfo);
 RunInfo=RunInfo(2:RunInfoLength-1);
  imageletterOverlay=strcat('AssociatedPhase- ',RunInfo);
  ProcessedImageBaseFolderPath=WritePath;
  %ProcessedImageBaseFolderPath=TopPathForOutput;
  ProcessedImageFolderPath=strcat(ProcessedImageBaseFolderPath,RunInfo);
  WriteOverlayImages=strcat(ProcessedImageFolderPath,imageletterOverlay);
  WritePathOverlay=strcat(WriteOverlayImages,'.csv');
 csvwrite(WritePathOverlay,AssociatePhases);
 fprintf('Now Writing Tracked Cell Data for %s\n',WritePathOverlay);


end 