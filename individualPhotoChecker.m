function [NewTest, centerholder, NewBW]=individualPhotoChecker(imageArray)
Slide=imageArray;
%Slide=imread('/Volumes/CellSlides/14-04-17 - T Cells on ICAM/60x RFP-V5-GCamp6f_01.oif.files/s_C003T102.tif');
image = imadjust(Slide);
%[NewTest]=circlemaker(image);
[NewTest]=image;
DetectionRound=0;
[NewTest, centerholder, NewBW]=imageSeperator(NewTest,DetectionRound);
DetectionRound=DetectionRound+1;
%[RemovedNoise, resetTracker]= NoiseRemover(centerholder, NewTest);
loops=1;%length(resetTracker);
counter=0;
Scrubbed=1; 
% while (Scrubbed==1)
%     [NewTest, centerholder, NewBW]=imageSeperator(NewTest,DetectionRound);
%     %[NewTest, centerholder, NewBW]=imageSeperator(RemovedNoise, DetectionRound); 
%     DetectionRound=DetectionRound+1;
%     %[RemovedNoise, resetTracker]= NoiseRemover(centerholder, NewTest);
%     counter=counter+1;
%     loops=1;%length(resetTracker);
%     if counter>=25
%         Scrubbed=0;
%     end
%     if (resetTracker(1,1)==0)
%         Scrubbed=0;
%     end 
% end
 %[NewTest, centerholder, NewBW]=imageSeperator(RemovedNoise, DetectionRound);
 
 DetectionRound=DetectionRound+1;
[NewTest, centerholder, NewBW]=imageSeperator(NewTest,DetectionRound);
end