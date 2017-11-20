function  nol  =  plane( points )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(points);
x=0;y=0;z=0;        %创建系数矩阵
for i=1:n     
    x=x-points(1,i);   
    y=y-points(2,i);   
    z=z-points(3,i); 
end
points1=points.';
a=points*points1; 
b=[x;y;z]; 
r=a\b;              %求解平面参数 A=r(1); B=r(2); C=r(3);
s=norm(r,2);
nol=[];
nol=[nol;r(1)/s;r(2)/s;r(3)/s;1/s];

