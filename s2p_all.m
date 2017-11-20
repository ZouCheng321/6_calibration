for i=1:16
    name='nube';
    name=strcat(name,num2str(i));
    name=strcat(name,'.asc');
    asc2pcd(name);    
end