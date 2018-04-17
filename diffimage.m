Nu=64; samplingu=0:1/(Nu-1):1;
Nv=64; samplingv=0:1/(Nv-1):1;
Nw=16; samplingw=0:1/(Nw-1):1;

[gu,gv,gw]=meshgrid(samplingu,samplingv,samplingw);

Xi=Fi_L(gu,gv,gw);
Yi=Fj_L(gu,gv,gw);
Zi=Fk_L(gu,gv,gw);

size_img=size(diff_nii.img);
for i_diff=1:size_img(4)
    in=1;
    clear in_i in_j in_k V Fimg
    i_diff
    for i_s=1:size_img(1)
        for j_s=1:size_img(2)
            for k_s=1:size_img(3)
                temp=World(diff_nii,i_s,j_s,k_s);
                temp=double(WorldI(U_nii,temp(1),temp(2),temp(3)));
                if (inShape(Hippo_alpha,temp(1),temp(2),temp(3))==1) %& Fu(i_s,j_s,k_s)~=0)
                    in_i(in)=i_s;
                    in_j(in)=j_s;
                    in_k(in)=k_s;
                    V(in)=diff_nii.img(i_s,j_s,k_s,i_diff);
                 in=in+1;
                end
            end
        end
    end
    Fimg=scatteredInterpolant(transpose(in_i),transpose(in_j),transpose(in_k),transpose(double(V)),'linear','none');
    for u_in=1:Nu
        for v_in=1:Nv
            for w_in=1:Nw
                X_c=Xi(u_in,v_in,w_in);
                Y_c=Yi(u_in,v_in,w_in);
                Z_c=Zi(u_in,v_in,w_in);
                temp=World(U_nii,X_c,Y_c,Z_c);
                temp=double(WorldI(diff_nii,temp(1),temp(2),temp(3)));
                diff_unfld(u_in,v_in,w_in,i_diff)=Fimg(temp(1),temp(2),temp(3));%interp3(j_u,i_u,k_u,U_nii.img,Y_c,X_c,Z_c,'cubic',-1);
            end
        end
    end
end
figure;
for tmp=2:9
 subplot(2,4,tmp-1);imagesc(flipud(squeeze(diff_unfld(:,:,tmp,243))));
    title(tmp);
end
