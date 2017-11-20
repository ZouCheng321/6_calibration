 clear;
 clc;
load Calib_Results.mat
load R2.mat;
load t2.mat;
im=imread('im1.jpg');
laser=readPcd('2.pcd')/1000;
laser=laser(:,1:3);
laserT=-R2*laser'-repmat(-t2,[1,size(laser,1)]);
V=[paramEst.xi,paramEst.kc',paramEst.alpha_c,paramEst.gammac',paramEst.cc'];


%  figure;imshow(im);hold on;
%  for i=1:size(laserT,2)
%  [P,dPdX] = spaceToImgPlane(laserT(:,i), V);
%  plot(P(1),P(2),'.r');
%  end


scan=spaceToImgPlane(laserT, V);
scan=fliplr(round(scan'));


cc=paramEst.cc;
Rmax=670;
Rmin=110;
n_points=size(laser,1);
scanRGB=ones(n_points,3);
imrows=size(im,1);
imcols=size(im,2);
inliers=find_model(scan,cc,Rmax,Rmin);
inliers_lindex=sub2ind([imrows imcols],scan(inliers,1),scan(inliers,2));
im=reshape(im,imrows*imcols,3);
scanRGB(inliers,:)=double(im(inliers_lindex,:)-1)/255;
pcd=[laser scanRGB];

a=1:size(scan,1);
outliers=setdiff(a,inliers)';
pcd(outliers,:)=[];
savepcd('1.pcd',pcd');

