% main file 
close all
clear all

pthf = './1';

% read Traget Image
im2=imread('./1/target.JPG');
PCM_Time = [];
NCC_Time = [];

for j = 1:11
    dr=strcat(pthf,'/',num2str(j),'.jpg');
    im1=imread(dr);
    PCM_start = cputime;
    % apply templete matching using PCM of the image
    resultPCM=partialCrossCorr(im1,im2);
    PCM_end = cputime;
    PCM_Time(j) = PCM_end - PCM_start;

    NCC_start = cputime;
    % apply templete matching using NCC of the image
    resultNCC=nCrossCo(im1,im2);
    NCC_end = cputime;
    NCC_Time(j) = NCC_end - NCC_start;
end

x = linspace(1,11,11);
figure; %plotting Time
bar(x,NCC_Time);
hold on
bar(x,PCM_Time);
legend('NCC Time','PCM Time'); 

% read Template image
im1=imread('./1/2.JPG');

% apply templete matching using PCM of the image
resultPCM=partialCrossCorr(im1,im2);

figure;
subplot(2,2,1),imshow(im1);title('Template');
subplot(2,2,2),imshow(im2);title('Target');
subplot(2,2,3),imshow(resultPCM);title('Matching Result using PCM');

% apply templete matching using NCC of the image
resultNCC=nCrossCo(im1,im2);

figure;
subplot(2,2,1),imshow(im1);title('Template');
subplot(2,2,2),imshow(im2);title('Target');
subplot(2,2,3),imshow(resultNCC);title('Matching Result using NCC');