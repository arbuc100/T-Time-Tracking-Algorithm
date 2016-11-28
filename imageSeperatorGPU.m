function [Newtest, centerholder, NewBW]= imageSeperatorGPU(image,counter)
%NewI=zeros(32,32,'uint16');
%Newtest=zeros(512,512,'uint16');
%NewBW=false(512,512,'logical');
checker=1;
centerholder=zeros(1,7,'double'); 
j=1;
k=1;
for k=0:15
    for j=0:15
        for x=1:32
            for y=1:32
             NewI(x,y)=image(((32*j)+x),((32*k)+y));
            end
        end
        NEWIGPU=gather(NewI);
        level=graythresh(NEWIGPU);
        if(counter<4)
             if level<0.25
                level=0.25;
             end
        else 
             if level<0.3
                level=0.3;
             end
            
        end
        BW=im2bw(NEWIGPU,level);
          for e=1:32
            for r=1:32
                 Newtest(((32*j)+e),((32*k)+r))=NewI(e,r);
                 NewBW(((32*j)+e),((32*k)+r))=BW(e,r);
            end
          end 
        center=regionprops(BW,'Centroid','Area','Perimeter','MajorAxisLength','MinorAxisLength','Eccentricity','Extent');
        center.Centroid;
        center.Area;
        center.Perimeter;
        center.MajorAxisLength;
        center.MinorAxisLength;
        center.Eccentricity;
        center.Extent;
        for n=1:length(center)
            if (center(n).Area >=75.0 && center(n).Area<=450) 
            centerholder((checker),1)=((32*k)+center(n).Centroid(:,1));
            centerholder((checker),2)=((32*j)+center(n).Centroid(:,2));
            centerholder((checker),3)=center(n).Area; 
            centerholder((checker),4)=center(n).Perimeter;
            centerholder((checker),5)=checker;
            centerholder((checker),6)=(center(n).MajorAxisLength);
            centerholder((checker),7)=(center(n).MinorAxisLength);
            centerholder((checker),8)=(center(n).Eccentricity);
            centerholder((checker),9)=(center(n).Extent);
            checker=checker+1;
            end 
        end
    end
end
[centerholder]=edgepoints(centerholder);
end