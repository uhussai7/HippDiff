%Get x,y,z lists, laplace fields are already as list
%just change name to something short
[x,y,z]=ind2sub(sz,idxgm);

u=Laplace_AP;
v=Laplace_PD;
w=Laplace_IO;

%Set up phi map and inverse
interp='linear';
extrap='none';

Fx=scatteredInterpolant(u,v,w,x,interp,extrap);
Fy=scatteredInterpolant(u,v,w,y,interp,extrap);
Fz=scatteredInterpolant(u,v,w,z,interp,extrap);

Fu=scatteredInterpolant(x,y,z,u,interp,extrap);
Fv=scatteredInterpolant(x,y,z,v,interp,extrap);
Fw=scatteredInterpolant(x,y,z,w,interp,extrap);

FdxU_w=scatteredInterpolant(x,y,z,dxU_w(idxgm),interp,extrap);
FdyU_w=scatteredInterpolant(x,y,z,dyU_w(idxgm),interp,extrap);
FdzU_w=scatteredInterpolant(x,y,z,dzU_w(idxgm),interp,extrap);

FdxV_w=scatteredInterpolant(x,y,z,dxV_w(idxgm),interp,extrap);
FdyV_w=scatteredInterpolant(x,y,z,dyV_w(idxgm),interp,extrap);
FdzV_w=scatteredInterpolant(x,y,z,dzV_w(idxgm),interp,extrap);

FdxW_w=scatteredInterpolant(x,y,z,dxW_w(idxgm),interp,extrap);
FdyW_w=scatteredInterpolant(x,y,z,dyW_w(idxgm),interp,extrap);
FdzW_w=scatteredInterpolant(x,y,z,dzW_w(idxgm),interp,extrap);

FdxU_p=scatteredInterpolant(u,v,w,dxU_w(idxgm),interp,extrap);
FdyU_p=scatteredInterpolant(u,v,w,dyU_w(idxgm),interp,extrap);
FdzU_p=scatteredInterpolant(u,v,w,dzU_w(idxgm),interp,extrap);

FdxV_p=scatteredInterpolant(u,v,w,dxV_w(idxgm),interp,extrap);
FdyV_p=scatteredInterpolant(u,v,w,dyV_w(idxgm),interp,extrap);
FdzV_p=scatteredInterpolant(u,v,w,dzV_w(idxgm),interp,extrap);

FdxW_p=scatteredInterpolant(u,v,w,dxW_w(idxgm),interp,extrap);
FdyW_p=scatteredInterpolant(u,v,w,dyW_w(idxgm),interp,extrap);
FdzW_p=scatteredInterpolant(u,v,w,dzW_w(idxgm),interp,extrap);




%leave out the thickness direction
F2x=scatteredInterpolant(u,v,x,interp,extrap);
F2y=scatteredInterpolant(u,v,y,interp,extrap);
F2z=scatteredInterpolant(u,v,z,interp,extrap);

%hippocampus mask
Hippo_alpha=alphaShape(x,y,z,4);