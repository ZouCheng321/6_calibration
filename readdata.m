function [ obj] = readdata(num)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
obj=cell(num,1);
for i=1:num
    name='jpg/imager';
    name=strcat(name,num2str(i));
    name=strcat(name,'.jpg');
    obj{i}.im=imread(name);
    
    name='txt/plane';
    name=strcat(name,num2str(i));
    name=strcat(name,'.txt');
    obj{i}.laserplane=importdata(name);
    
    name='pts/pts';
    name=strcat(name,num2str(i));
    name=strcat(name,'.mat');
    load(name);
    obj{i}.implane= plane( pts );
    
     name='asc/nube';
    name=strcat(name,num2str(i));
    name=strcat(name,'.asc');
    obj{i}.laser=textread(name, '' , 'headerlines', 2);
end

end

