%Find bounding box for T2
Usize=size(U_nii.img);
hipbox=zeros(6,4);
hipbox(:,4)=1;
hipbox(1,1)=1;hipbox(3,2)=1;hipbox(5,3)=1;
hipbox(2,1)=Usize(1);hipbox(4,2)=Usize(2);hipbox(6,3)=Usize(3);

for hp=1:6
    hipbox(hp,:)=World(U_nii,hipbox(hp,1),hipbox(hp,2),hipbox(hp,3));
end

for hp=1:6
    hipbox(hp,:)=int16(WorldI(T2_nii,hipbox(hp,1),hipbox(hp,2),hipbox(hp,3)));
end





Nu=200; samplingu=0:1/(Nu-1):1;
Nv=200; samplingv=0:1/(Nv-1):1;
Nw=10; samplingw=0:1/(Nw-1):1;

[gu,gv,gw]=meshgrid(samplingu,samplingv,samplingw);

Xi=Fi_L(gu,gv,gw);
Yi=Fj_L(gu,gv,gw);
Zi=Fk_L(gu,gv,gw);

in=1;
size_img=size(T2_nii.img);
clear in_i in_j in_k V TestU
%for i_s=1:size_img(1)
%    for j_s=1:size_img(2)
%        for k_s=1:size_img(3)
for i_s=hipbox(1,1):hipbox(2,1)
    for j_s=hipbox(3,2):hipbox(4,2)
        for k_s=hipbox(5,3):hipbox(6,3)          
            temp=World(T2_nii,i_s,j_s,k_s);
            temp=double(WorldI(U_nii,temp(1),temp(2),temp(3)));
            %transpose(temp);
            if (inShape(Hippo_alpha,temp(1),temp(2),temp(3))==1) %& Fu(i_s,j_s,k_s)~=0)
            %if (inShape(Hippo_alpha,i_s,j_s,k_s)==1) %& Fu(i_s,j_s,k_s)~=0)
            %if(Fu(i_s,j_s,k_s) ~=0)
            %if U_nii.img(i_s,j_s,k_s)>0
            %temp=World(T2_nii,i_s,j_s,k_s);
            %temp=double(WorldI(U_nii,temp(1),temp(2),temp(3)));
            %temp(1),temp(2),temp(3)
                in_i(in)=i_s;
                in_j(in)=j_s;
                in_k(in)=k_s;
                V(in)=T2_nii.img(i_s,j_s,k_s);
                %if V(in)~=0
                %    V(in)
                %end
                in=in+1;
            end
        end
    end
end
TestU=scatteredInterpolant(transpose(in_i),transpose(in_j),transpose(in_k),transpose(double(V)),'nearest','none');

            
[j_u,i_u,k_u]=meshgrid(1:53,1:38,1:48); %notice how x and y are flipped here and below in the query
testu=zeros(Nu,Nv,Nw);
testu_good=zeros(Nu,Nv,Nw);
for u_in=1:Nu
    for v_in=1:Nv
        for w_in=1:Nw
            X_c=Xi(u_in,v_in,w_in);
            Y_c=Yi(u_in,v_in,w_in);
            Z_c=Zi(u_in,v_in,w_in);
            temp=World(U_nii,X_c,Y_c,Z_c);
            temp=double(WorldI(T2_nii,temp(1),temp(2),temp(3)));

            %if isnan(X_c)==1 X_c=0; end
            %if isnan(Y_c)==1 Y_c=0; end
            %if isnan(Z_c)==1 Z_c=0; end
            %if isnan(X_c)== 0 & isnan(Y_c)== 0 & isnan(Z_c)== 0
                %if inShape(Hippo_alpha,X_c,Y_c,Z_c)==1
                    %testu_good(u_in,v_in,w_in)=Fu(X_c,Y_c,Z_c);%interp3(j_u,i_u,k_u,U_nii.img,X_c,Y_c,Z_c,'linear');
                    %testu(u_in,v_in,w_in)=TestU(X_c,Y_c,Z_c);%interp3(j_u,i_u,k_u,U_nii.img,Y_c,X_c,Z_c,'cubic',-1);
                    
                    testu(u_in,v_in,w_in)=TestU(temp(1),temp(2),temp(3));%interp3(j_u,i_u,k_u,U_nii.img,Y_c,X_c,Z_c,'cubic',-1);

                %end
            %end    
        end
    end
end

figure;
for tmp=2:9
 subplot(2,4,tmp-1);imagesc(flipud(squeeze(testu(:,:,tmp))));
    title(tmp);
end


