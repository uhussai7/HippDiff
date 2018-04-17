%Setup UVW grid
Nu=100;samplingu=0:1/(Nu-1):1;
Nv=100;samplingv=0:1/(Nv-1):1;
Nw=100;samplingw=0:1/(Nw-1):1;

[Ug,Vg,Wg]=meshgrid(samplingu,samplingv,samplingw);
%[Ug,Vg]=meshgrid(samplingu,samplingv);


dxU_p=FdxU_p(Ug,Vg,Wg);
dxV_p=FdxV_p(Ug,Vg,Wg);
dxW_p=FdxW_p(Ug,Vg,Wg);

X_p=Fx(Ug,Vg,Wg);
X_p(X_p==0)=NaN;

[duX_p,dvX_p,dwX_p]=gradient(X_p,0.0101);

check=dxU_p.*duX_p+dxV_p.*dvX_p+dxW_p.*dwX_p;

figure;imagesc(squeeze(check(:,:,50)));

imagesc(squeeze(X_p(:,:,50)));

hist(check,10);

check=rmNaN(check);


figure;contour(squeeze(Ug(:,:,50)), squeeze(Vg(:,:,50)),squeeze(X_p(:,:,50)));
hold on;quiver(squeeze(Ug(:,:,50)), squeeze(Vg(:,:,50)), squeeze(duX_p(:,:,50)),squeeze(dvX_p(:,:,50)),7);
hold on;quiver(squeeze(Ug(:,:,50)), squeeze(Vg(:,:,50)), squeeze(dxU_p(:,:,50)),squeeze(dxV_p(:,:,50)),7);

quiver(Ug,Vg,dxU_p,dxV_p);

dxU2=squeeze(dxU_p(:,:,50));
dxV2=squeeze(dxV_p(:,:,50));

quiver( dxU2,dxV2,40);



