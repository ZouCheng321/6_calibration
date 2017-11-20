function cost = computeRMSDiffDistanceToPlanes(pc,thetac,alphac,thetal,alphal)


cost = sqrt(mean( (abs(pc'*thetac - alphac) - alphal).^2 ));