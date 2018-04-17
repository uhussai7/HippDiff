function Iout = Iuvw(Ixyz_nii,roi,min_xyz,Xi,Yi,Zi)
%min_xyz is for staring position of box
global U_nii;
global Hippo_alpha;
size_Xi=size(Xi);
%size_Xi;
sizeroi=size(roi);
in=1;
clear V in_i in_j in_k Fimg
for i_s=1:sizeroi(1)
    for j_s=1:sizeroi(2)
        for k_s=1:sizeroi(3)
            %temp=(World(Ixyz_nii,min_xyz(1)+i_s-1,min_xyz(2)+j_s-1,min_xyz(3)+k_s-1));
%             i_s
%             j_s
%             k_s
%             temp
            temp=(World(Ixyz_nii,i_s,j_s,k_s));
            temp=double(WorldI(U_nii,temp(1),temp(2),temp(3)));
            if (inShape(Hippo_alpha,temp(1),temp(2),temp(3))==1 & isnan(roi(i_s,j_s,k_s))~=1)
                V(in)=roi(i_s,j_s,k_s);
                in_i(in)=i_s;
                in_j(in)=j_s;
                in_k(in)=k_s;
                in=in+1;
            end
        end
    end
end

%figure;scatter3(in_i,in_j,in_k);

Fimg=scatteredInterpolant(transpose(in_i),transpose(in_j),transpose(in_k),transpose(double(V)),'linear','none');

    
for u_in=1:size_Xi(1)
    for v_in=1:size_Xi(2)
        for w_in=1:size_Xi(3)
            X_c=Xi(u_in,v_in,w_in);
            Y_c=Yi(u_in,v_in,w_in);
            Z_c=Zi(u_in,v_in,w_in);
            if(isnan(X_c)==0 & isnan(Y_c)==0 & isnan(Z_c)==0)
                temp=World(U_nii,X_c,Y_c,Z_c);
                temp=WorldI(Ixyz_nii,temp(1),temp(2),temp(3));
%                 temp(1)=temp(1)-min_xyz(1)+1;
%                 temp(2)=temp(2)-min_xyz(2)+1;
%                 temp(3)=temp(3)-min_xyz(3)+1;
                Iout(u_in,v_in,w_in)=Fimg(temp(1),temp(2),temp(3));
            end
        end
    end
end

end




