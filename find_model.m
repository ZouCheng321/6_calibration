function model=find_model(scan,cc,Rmax,Rmin);



imXY=(scan(:,1)-cc(2)).^2+(scan(:,2)-cc(1)).^2;

model=(find((imXY<Rmax^2)&(imXY>Rmin^2)));


end

