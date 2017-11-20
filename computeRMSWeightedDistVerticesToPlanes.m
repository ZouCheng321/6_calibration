function cost = computeRMSWeightedDistVerticesToPlanes(par, ...
    planePoints,n_planePoints,thetac,alphac)

q = par(1:4);
t = par(5:7);
R = quat2rot(q);
cost=0; count=0;
cn_planePoints=cumsum(n_planePoints);
for i=1:length(n_planePoints)    
    %vert = planeVertices((4*i-3):(4*i),:);
    if(i==1)
        vert = planePoints(1:cn_planePoints(i),:);
    else
        vert = planePoints((cn_planePoints(i-1)+1):cn_planePoints(i),:);
    end
    theta = thetac(:,i);
    % Sum of square distances of points transformed to camera frame to
    % planes in camera frame
    cost=cost+mean((theta'*(R*vert'-repmat(t,1,n_planePoints(i)))-alphac(i)).^2);
end
cost=sqrt(cost./length(n_planePoints));