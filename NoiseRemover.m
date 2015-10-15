
function [RemovedNoise, resetTracker]= NoiseRemover(centerholder, NewTest)
p=1;
n=1;
RemovedNoise=NewTest;
resetTracker=zeros(1,1,'double');
for(n=1:size(centerholder,1))
   if centerholder(n,3)>100
       centerRoundness=(centerholder(n,6)/centerholder(n,7));
        if ((centerRoundness<1.8 && centerRoundness>0.7) || centerholder(n,4)>175)
            resetTracker(p)=centerholder(n,5);
            p=p+1;
            if centerholder(n,1)<15
                resetx=1;
                resety=round((centerholder(n,2)-15));
            elseif centerholder(n,1)>496
                resetx=483;
                resety=round((centerholder(n,2)-15));
            elseif centerholder(n,2)<15
                resety=1;
                resetx=round((centerholder(n,1)-15));
            elseif centerholder(n,2)>496
                resety=483;
                resetx=round((centerholder(n,1)-15));
            else
                resetx=round((centerholder(n,1)-15));
                resety=round((centerholder(n,2)-15));
            end
            if resetx<1
                resetx=1;
            end
            if resety<1
                resety=1;
            end
            if resety>(512-29)
                resety= (512-29);
            end
            if resetx>(512-29)
                resetx=(512-29);
            end
            
            for k=0:29
                for j=0:29
                    if((sqrt((k-15)^2 + (j-15)^2) <= (centerholder(n,6)/2)) && RemovedNoise((resety+j),(resetx+k))>10000)
                        RemovedNoise((resety+j),(resetx+k))=8000;
                    end
                end
            end
        end
   end
end
end
