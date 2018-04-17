function Iout = Iuvw(Ixyz_nii,Xi,Yi,Zi)
%IUVW Summary of this function goes here
%   Detailed explanation goes here
global U_nii;
global Hippo_alpha;

size_img=size(Ixyz_nii.img);
size_Xi=size(Xi);
size_of_size=size(size_img)

if(size_of_size(2)>3)
    diff_size=size_img(4);
else
    diff_size=1;
end
diff_size
for i_diff=1:diff_size;
    in=1;
    clear in_i in_j in_k V Fimg
    i_diff
    for i_s=1:size_img(1)
        for j_s=1:size_img(2)
            for k_s=1:size_img(3)
                temp=World(Ixyz_nii,i_s,j_s,k_s);
                temp=double(WorldI(U_nii,temp(1),temp(2),temp(3)));
                %if (inShape(Hippo_alpha,temp(1),temp(2),temp(3))==1) %& Fu(i_s,j_s,k_s)~=0)
                    
                    if(diff_size==1 & isnan(Ixyz_nii.img(i_s,j_s,k_s))==0)
                        V(in)=Ixyz_nii.img(i_s,j_s,k_s);
                        in_i(in)=i_s;
                        in_j(in)=j_s;
                        in_k(in)=k_s;
                    elseif(diff_size~=1 & isnan(Ixyz_nii.img(i_s,j_s,k_s))== 0)
                        V(in)=Ixyz_nii.img(i_s,j_s,k_s,i_diff);
                        in_i(in)=i_s;
                        in_j(in)=j_s;
                        in_k(in)=k_s;
                    end
                    in=in+1;
                %end
            end
        end
    end
    
    clear Hippo_I;
    clear TRI_Ixyz;
    clear TRI_Ixyz_c;
    
    Hippo_I=alphaShape(transpose(in_i),transpose(in_j),transpose(in_k));
    spc_I=alphaSpectrum(Hippo_I);
    Hippo_I.Alpha=min(spc_I);
    TRI_Ixyz=delaunayTriangulation(transpose(in_i),transpose(in_j),transpose(in_k));
    
    %get center points of triangulation
    IC = incenter(TRI_Ixyz);  
    szic=size(IC);
    %go through center points - remove triangles that are outside alpha shape
    clear cnct; 
    ic_i2=1;
    for ic_i=1:szic(1)
        if(inShape(Hippo_I,IC(ic_i,1),IC(ic_i,2),IC(ic_i,3))==1)
            cnct(ic_i2,:)=TRI_Ixyz.ConnectivityList(ic_i,:);
            ic_i2=ic_i2+1;
        end
    end
    
    TRI_Ixyz_c=triangulation(cnct,TRI_Ixyz.Points);


    %Fimg=scatteredInterpolant(transpose(in_i),transpose(in_j),transpose(in_k),transpose(double(V)),'linear','none');
    
    for u_in=1:size_Xi(1)
        for v_in=1:size_Xi(2)
            for w_in=1:size_Xi(3)
                X_c=Xi(u_in,v_in,w_in);
                Y_c=Yi(u_in,v_in,w_in);
                Z_c=Zi(u_in,v_in,w_in);
                if(isnan(X_c)==0 & isnan(Y_c)==0 & isnan(Z_c)==0)
                    %if(inShape(Hippo_alpha,X_c,Y_c,Z_c)==1)
                        temp=World(U_nii,X_c,Y_c,Z_c);
                        temp=double(WorldI(Ixyz_nii,temp(1),temp(2),temp(3)));
                        %Iout(u_in,v_in,w_in,i_diff)=Fimg(temp(1),temp(2),temp(3));%interp3(j_u,i_u,k_u,U_nii.img,Y_c,X_c,Z_c,'cubic',-1);
                        ID=pointLocation(TRI_Ixyz_c,temp(1),temp(2),temp(3));
                        if(isnan(ID)==1)
                            Iout(u_in,v_in,w_in,i_diff)=NaN;
                        end
                        B = cartesianToBarycentric(TRI_Ixyz_c,ID,[temp(1),temp(2),temp(3)]);
                        V_ID=[TRI_Ixyz_c.ConnectivityList(ID,1),TRI_Ixyz_c.ConnectivityList(ID,2),TRI_Ixyz_c.ConnectivityList(ID,3),TRI_Ixyz_c.ConnectivityList(ID,4)];
                        Iout(u_in,v_in,w_in,i_diff)=B(1)*V(V_ID(1))+B(2)*V(V_ID(2))+B(3)*V(V_ID(3));
                    %end
                end
            end
        end
    end
end




