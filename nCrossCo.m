function result=nCrossCo(image1,image2)

if size(image1,3)==3
    image1=rgb2gray(image1);
end
if size(image2,3)==3
    image2=rgb2gray(image2);
end

% check which one is target and which one is template using their size

if size(image1)>size(image2)
    Target=image1;
    Template=image2;
else
    Target=image2;
    Template=image1;
end

% find both images sizes
[r1,c1]=size(Target);
[r2,c2]=size(Template);
% mean of the template
image3=Template-mean(mean(Template));

%corrolate both images
M=[];
for i=1:(r1-r2+1)
    for j=1:(c1-c2+1)
        Nimage=Target(i:i+r2-1,j:j+c2-1);
        Nimage=Nimage-mean(mean(Nimage));  % mean of image part under mask
        covv=sum(sum(Nimage.*image3));
        warning off
        M(i,j)=covv/sqrt(sum(sum(Nimage.^2))*sum(sum(image3.^2)));
    end 
end
% plot box on the target image
result=plotbox(Target,Template,M);