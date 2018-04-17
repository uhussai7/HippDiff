%global TRIuvw
global TRIxyz
global TRIxyz_c
global TRIuvw_c

TRIuvw_c=delaunayTriangulation(u,v,w);
TRIxyz=delaunayTriangulation(i_L,j_L,k_L);



%get center points of triangulation
IC = incenter(TRIuvw_c);
szic=size(IC);
%go through center points - remove triangles that are outside alpha shape
clear cnct;
ic_i2=1;
for ic_i=1:szic(1)
    if(inShape(uvw_alpha,IC(ic_i,1),IC(ic_i,2),IC(ic_i,3))==1)
        cnct(ic_i2,:)=TRIuvw_c.ConnectivityList(ic_i,:);
        ic_i2=ic_i2+1;
    end
end

clear TRIuvw;
TRIuvw=triangulation(cnct,TRIuvw_c.Points);

TRIxyz_c=triangulation(cnct,TRIxyz.Points);


IC = incenter(TRIxyz_cut);

scatter3(IC(:,1),IC(:,2),IC(:,3));
hold on; plot(Hippo_alpha);hold off;

[F,P] = freeBoundary(TRIuvw);
trisurf(F,P(:,1),P(:,2),P(:,3), ...
       'FaceColor','cyan','FaceAlpha',0.8);

trisurf(TRIuvw);




