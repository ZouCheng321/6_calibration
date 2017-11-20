function asc2pcd(fname)


points=textread(fname, '' , 'headerlines', 2);


pcdname=fname(1:end-3);
pcdname=strcat('plane_',pcdname);
pcdname=strcat(pcdname,'pcd')

savepcd(pcdname,points');

