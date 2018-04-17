%raw scatter plots
scatter3(x,y,z,[],u);


%setup XYZ grid

[Xg,Yg,Zg]=meshgrid(1:5:sz(1),1:5:sz(2),1:5:sz(3));

%convert Laplace fields to matrix
u_w=zeros(sz);
v_w=zeros(sz);
w_w=zeros(sz);

imagesc(squeeze(u_w(:,:,32)));

u_w(idxgm)=u;
v_w(idxgm)=v;
w_w(idxgm)=w;

u_w(u_w==0)=NaN;
v_w(v_w==0)=NaN;
w_w(w_w==0)=NaN;

%compute gradients in XYZ space
[dyU_w, dxU_w, dzU_w]=gradient(u_w);
[dyV_w, dxV_w, dzV_w]=gradient(v_w);
[dyW_w, dxW_w, dzW_w]=gradient(w_w);

dxU_w=rmNaN(dxU_w);
dyU_w=rmNaN(dyU_w);
dzU_w=rmNaN(dzU_w);

dxV_w=rmNaN(dxV_w);
dyV_w=rmNaN(dyV_w);
dzV_w=rmNaN(dzV_w);

dxW_w=rmNaN(dxW_w);
dyW_w=rmNaN(dyW_w);
dzW_w=rmNaN(dzW_w);



dxU_w_d=FdxU_w(Xg,Yg,Zg);
dyU_w_d=FdyU_w(Xg,Yg,Zg);
dzU_w_d=FdzU_w(Xg,Yg,Zg);

hold on;quiver3(Xg,Yg,Zg,dxU_w_d,dyU_w_d,dzU_w_d,4);

dxV_w_d=FdxV_w(Xg,Yg,Zg);
dyV_w_d=FdyV_w(Xg,Yg,Zg);
dzV_w_d=FdzV_w(Xg,Yg,Zg);

figure;quiver3(Xg,Yg,Zg,dxV_w_d,dyV_w_d,dzV_w_d,4);

dxW_w_d=FdxW_w(Xg,Yg,Zg);
dyW_w_d=FdyW_w(Xg,Yg,Zg);
dzW_w_d=FdzW_w(Xg,Yg,Zg);

quiver3(Xg,Yg,Zg,dxW_w_d,dyW_w_d,dzW_w_d);