function [centerholder]=edgepoints(centerholder)
holder=1;
similar=0;
for (n=1:size(centerholder,1))
    xCoord=centerholder(n,1);
    yCoord=centerholder(n,2);
    xedge=mod(xCoord,32);
    yedge=mod(yCoord,32);
    same=0;
    if xedge<6 || yedge<6 ||xedge>26 ||yedge>26
            for j=1:size(centerholder,1)
               xCloseness=abs(xCoord-centerholder(j,1));
                yCloseness=abs(yCoord-centerholder(j,2));
                totalCloseness=xCloseness+yCloseness;
                if yCloseness ~= 0 &&xCloseness ~=0
                    if(xCloseness< 15 && yCloseness< 15 && totalCloseness<16.5) 
                        closest1(holder,1)=centerholder(n,1);
                        closest1(holder,2)=centerholder(n,2);
                        closest1(holder,3)=centerholder(n,5);
                        closest1(holder,4)=centerholder(j,1);
                        closest1(holder,5)=centerholder(j,2);
                        closest1(holder,6)=centerholder(j,5);
                        closest1(holder,7)=xCloseness;
                        closest1(holder,8)=yCloseness;
                        closest1(holder,9)=same;
                        holder=holder+1;
                        same=same+1;
                        similar=1;
                    end
                end
            end
    end
end
held=1;
if similar==1
for(w=1:size(closest1,1))
    merged(held,1)=closest1(w,3);
    merged(held,2)=closest1(w,6);
    merged(held,3)=((closest1(w,1)+closest1(w,4))/2);
    merged(held,4)=((closest1(w,2)+closest1(w,5))/2);
    merged(held,5)=closest1(w,9); 
    held=held+1;
end
holded=1;
for z=1:size(merged,1)
            for m=1:size(merged,1)
                if(merged(z,1) == merged(m,1) && merged(z,2)~=merged(m,2))
                    merged(z,1)=merged(z,1);
                    merged(z,2)=merged(z,2);
                    xMerge=((merged(z,3)+merged(m,3))/2);
                    yMerge=((merged(z,4)+merged(m,4))/2);
                    merged(z,3)=xMerge;
                    merged(z,4)=yMerge;
                    merged(z,5)=0;
                    merged(m,5)=0;
                    merged(m,1)=merged(z,1);
                    merged(m,2)=merged(m,2);
                    merged(m,3)=xMerge;
                    merged(m,4)=yMerge;
                end
            end
end
for z=1:size(merged,1)
            for m=1:size(merged,1)
                if(merged(z,1) == merged(m,2) && merged(z,2)==merged(m,1))
                    merged(z,5)=1;
                    merged(m,5)=1;
                end
            end
end

for(a=1:size(merged,1))
    b=1;
   while (b<=size(centerholder,1))
       if merged(a,1)==centerholder(b,5)
           centerholder(b,1)=merged(a,3);
           centerholder(b,2)=merged(a,4);
           b=b+1;
       elseif (merged(a,2)==centerholder(b,5)&& merged(a,5)<1)
            centerholder(b,:)=[];
            b=b+1;
       else
           b=b+1;
       end
   end
end
end 
end