function [NewTest1] =circlemaker(image)
[centers,radii,metric]=imfindcircles(image,[10 30]);
NewTest1=image;
for(n=1:size(centers,1))
    x=centers(n,1);
    y=centers(n,2);
    raduis=round(radii(n));
    for(i=0:round(radii(n)))
        for(j=0:round(radii(n)))
            xradplus=round((x+j));
            xradminus=round((x-j));
            yradplus=round((y+i));
            yradminus=round((y-i));
            
            if( yradplus<=512 && xradplus<=512 ) %&& round((y-i))>=1 &&(round((x-j)))>=1)
                if ((sqrt((i)^2 + (j)^2))<=(radii(n))+1)        
                    NewTest1(yradplus,xradplus)=8000;
                end
            end
            if (yradplus<=512 && xradminus>=1) 
                if ((sqrt((i)^2 + (j)^2))<=(radii(n)+1))
                    NewTest1(yradplus,xradminus)=8000;
                end
            end
            if (yradminus>=1 && xradminus>=1)
                if ((sqrt((i)^2 + (j)^2))<=(radii(n)+1))
                    NewTest1(round((y-i)),round((x-j)))=8000;
                end
            end
            if( yradminus>=1 && xradplus<=512)
                if ((sqrt((i)^2 + (j)^2))<=(radii(n)+1))
                    NewTest1(yradminus,xradplus)=8000;
                end
            end
        end
    end
end
end
% for(i=1:size(centers,1))
% circleholder(i,1)=centers(i,1);
% circleholder(i,2)=centers(i,2);
% circleholder(i,3)=i;
% circleholder(i,4)=radii(i,1);
% circleholder(i,5)=metric(i,1);
% end
% figure,imshow(NewTest1, []);title('"Removed" blobs');
%  hold on;
%  plot(circleholder(:,1),circleholder(:,2),'r+','MarkerSize',20,'LineWidth',1);
%  text(circleholder(:,1),circleholder(:,2),num2str(circleholder(:,3)),'Color','r');
%  hold off;

