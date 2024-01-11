function result=partialCrossCorr(image1,image2)

if size(image1,3)==3
    image1=rgb2gray(image1);
end
if size(image2,3)==3
    image2=rgb2gray(image2);
end

% check which one
% is target and which one is template using their size

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

%corrolate both images
M=[];
rhoTh = 0;
for i=1:(r1-r2+1)
    for j=1:(c1-c2+1)

        for p = 4:-1:1
            u2 = fix(r2/p);
            v2 = fix(c2/p);
            partialTemplate=Template(1:u2,1:v2);
            partialTemplate = partialTemplate - mean(mean(partialTemplate));
            Nimage=Target(i:i+u2-1,j:j+v2-1);
            Nimage=Nimage-mean(mean(Nimage));
            covv=sum(sum(Nimage.*partialTemplate));
            warning off
            partialRho = covv/sqrt(sum(sum(Nimage.^2))*sum(sum(partialTemplate.^2)));
            if partialRho < rhoTh
                break;
            end
        end
        M(i,j) = partialRho;
        if partialRho > rhoTh
            rhoTh = partialRho;
        end

    end 
end
% plot box on the target image
result=plotbox(Target,Template,M);