su=0;
eu=1;

sv=0;
ev=1;

sw=0;
ew=1.0;

clear samplingu samplingv samplingw;
clear gu gv gw;
Nu=64; samplingu=su:(eu-su)/(Nu-1):eu;
Nv=64; samplingv=sv:(ev-sv)/(Nv-1):ev;
Nw=10; samplingw=sw:(ew-sw)/(Nw-1):ew;

[gu,gv,gw]=meshgrid(samplingu,samplingv,samplingw);


clear Xi Yi Zi;
for int_u=1:Nu
    for int_v=1:Nv
        for int_w=1:Nw
%             disp(samplingu(int_u));
%             disp(samplingv(int_v));
%             disp(samplingw(int_w));
            r_q=Unfld2Native(samplingu(int_u),samplingv(int_v),samplingw(int_w),TRIxyz_c,TRIuvw_c);
            Xi(int_u,int_v,int_w)=r_q(1);
            Yi(int_u,int_v,int_w)=r_q(2);
            Zi(int_u,int_v,int_w)=r_q(3);
        end
    end
end

figure;
for temp=1:Nw
imagesc(squeeze(Xi(:,:,temp)));
pause(0.6);
end;

graddev_uvw=Iuvw(grad_dev_crop_nii,Xi,Yi,Zi);
graddev_phi_uvw=Iuvw(graddev_phi_nonan_nii,Xi,Yi,Zi);
U_uvw=Iuvw(U_nii,Xi,Yi,Zi);

clear u1 v1 w1 u1 j1 k1
clear u2 v2 w2 u2 j2 k2
clear u3 v3 w3 u3 j3 k3
clear u4 v4 w4 u4 j4 k4
jj1=1;jj2=1;jj3=1;jj4=1;
for ii=1:6958
    if (w(ii)<=samplingw(1) & w(ii)<samplingw(2))
       u1(jj1)=u(ii);
       v1(jj1)=v(ii);
       w1(jj1)=w(ii);
       i1(jj1)=i_L(ii);
       j1(jj1)=j_L(ii);
       k1(jj1)=k_L(ii);
       jj1=jj1+1;
    end
    
    if (w(ii)<=samplingw(2) & w(ii)<samplingw(3))
       u2(jj2)=u(ii);
       v2(jj2)=v(ii);
       w2(jj2)=w(ii);
       i2(jj2)=i_L(ii);
       j2(jj2)=j_L(ii);
       k2(jj2)=k_L(ii);
       jj2=jj2+1;
    end    
    if (w(ii)<=samplingw(3) & w(ii)<samplingw(4))
       u3(jj3)=u(ii);
       v3(jj3)=v(ii);
       w3(jj3)=w(ii);
       i3(jj3)=i_L(ii);
       j3(jj3)=j_L(ii);
       k3(jj3)=k_L(ii);
       jj3=jj3+1;
    end
    if (w(ii)<=samplingw(4) & w(ii)<samplingw(5))
       u4(jj4)=u(ii);
       v4(jj4)=v(ii);
       w4(jj4)=w(ii);
       i4(jj4)=i_L(ii);
       j4(jj4)=j_L(ii);
       k4(jj4)=k_L(ii);
       jj4=jj4+1;
    end
end

figure;   
for s=1:9
    %for t=1:8
    subplot(3,3,s);imagesc(squeeze(graddev_phi_uvw(:,:,3,s)));
    title(s);
    %end
end

figure;imagesc(squeeze(U_uvw(:,:,4)));
size(grad_dev_crop_nii.img)

%create a triangulation
TRIuv=delaunayTriangulation(transpose(u2),transpose(v2));
triplot(TRIuv);

%check alpha shape
alpha2d=alphaShape(transpose(u2),transpose(v2),'HoleThreshold',1);
hold on;plot(alpha2d);

%get center points of triangulation
IC = incenter(TRIuv);
szic=size(IC);
%go through center points - remove triangles that are outside alpha shape
clear connect;
ic_i2=1;
for ic_i=1:szic(1)
    if(inShape(alpha2d,IC(ic_i,1),IC(ic_i,2))==1)
        connect(ic_i2,:)=TRIuv.ConnectivityList(ic_i,:);
        ic_i2=ic_i2+1;
    end
end
TRIuvcopy = struct('Points', TRIuv.Points, 'ConnectivityList', connect);
triplot(TRIuvcopy);
trisurf( connect,TRIuvcopy.Points);
TR = triangulation(connect,TRIuv.Points);
triplot(TR);


scatter(IC(:,1),IC(:,2))


%triangle containing 
ID=pointLocation(TRIuv,0.5,0.5)
Tind=TRIuv.ConnectivityList(ID,:);
Tu(1)=u2(Tind(1));Tv(1)=v2(Tind(1));
Tu(2)=u2(Tind(2));Tv(2)=v2(Tind(2));
Tu(3)=u2(Tind(3));Tv(3)=v2(Tind(3));


%% some diagnostics
A=isnan(w_w)==0;
B=isnan(graddev_phi_nonan(:,:,:,9))==0;

C=double(A-B);
figure;imagesc(squeeze(A(:,:,40)));
figure;imagesc(squeeze(B(:,:,40)));
figure;imagesc(squeeze(graddev_phi_nonan(:,:,40,9)));

figure;imagesc(squeeze(w_w(:,:,39)));
figure;imagesc(squeeze(w_w(:,:,40)));
figure;imagesc(squeeze(w_w(:,:,41)));




hist(C,100);

dump=1;th=1;
size_Xi=size(Xi);
clear X_h Y_h Z_h u_h v_h w_h
for u_in=1:size_Xi(1)
    for v_in=1:size_Xi(2)
        for w_in=1:size_Xi(3)
            X_c=Xi(u_in,v_in,w_in);
            Y_c=Yi(u_in,v_in,w_in);
            Z_c=Zi(u_in,v_in,w_in);
            X_h(dump)=X_c;
            Y_h(dump)=Y_c;
            Z_h(dump)=Z_c;
            u_h(dump)=gu(u_in,v_in,w_in);      
            v_h(dump)=gv(u_in,v_in,w_in);          
            w_h(dump)=gw(u_in,v_in,w_in);          

            
            if(isnan(X_c)==0 & isnan(Y_c)==0 & isnan(Z_c)==0)
                if(inShape(Hippo_alpha,X_c,Y_c,Z_c)==0)
                    %temp=World(U_nii,X_c,Y_c,Z_c);
                    %temp=double(WorldI(Ixyz_nii,temp(1),temp(2),temp(3)));
                    %Iout(u_in,v_in,w_in,i_diff)=Fimg(temp(1),temp(2),temp(3));%interp3(j_u,i_u,k_u,U_nii.img,Y_c,X_c,Z_c,'cubic',-1);
                    w_out(th)=w_h(dump);
                    th=th+1;
                end
            end
            
            dump=dump+1;
        end
    end
end

figure;scatter3(X_h,Y_h,Z_h,[],u_h);
hold on; plot(Hippo_alpha);hold off;

figure;scatter3(i_L,j_L,k_L);

test=alphaShape(X_h,Y_h,Z_h);
