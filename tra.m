num=16;
obj= readdata(num);


thetac=[];
alphac=[];
for i=1:num
    theta=obj{i}.implane(1:3,:);
    alpha=obj{i}.implane(4);
    
    if(alpha<0)
        theta=-theta; alpha=-alpha;
    end
    
    thetac=[thetac theta];
    alphac=[alphac alpha];
end
alphac=alphac;


thetal=[]; alphal=[];
planePoints=[];
n_planePoints=[];

for i=1:num
    theta=obj{i}.laserplane(1:3,:);
    alpha=obj{i}.laserplane(4);
    if(alpha<0)
        theta=-theta; alpha=-alpha;
    end
    thetal=[thetal theta];
    alphal=[alphal alpha];
    planePoints=[planePoints;obj{i}.laser];
    n_planePoints=[n_planePoints;size(obj{i}.laser,1)];
end


t1=zeros(3,1); R1=eye(3);

% Closed form solution
t_est=inv(thetac*thetac')*thetac*(alphac-alphal)';

% Adjust by t_estt_start=mean(thetal.*repmat(alphal,3,1),2) ...

t1=t1+t_est;

fprintf(1,'Computed RMS error in distance to planes: %f\n',...
    computeRMSDiffDistanceToPlanes(t_est,thetac,alphac,thetal,alphal));

[U,S,V]=svd(thetal*thetac');
R=V*U';

R1=R;



% point=R1*obj{4}.laser'-repmat(t1,[1,size(obj{4}.laser,1)]);








