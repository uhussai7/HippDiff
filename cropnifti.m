%load the full laplace nifti files
U_nii=load_untouch_nii('sub-899885_T2w_space-full_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz');
V_nii=load_untouch_nii('sub-899885_T2w_space-full_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz');
W_nii=load_untouch_nii('sub-899885_T2w_space-full_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz');

%clip out the hippocampus
inds_full=find(U_nii.img>0);
[x_m,y_m,z_m]=ind2sub(size(U_nii.img),inds_full);
min_m=[min(x_m),min(y_m),min(z_m)];
max_m=[max(x_m),max(y_m),max(z_m)];
diff=max_m-min_m+3;
cropping=zeros(size(U_nii.img));
cropping(min(x_m)-1:max(x_m)+1,min(y_m)-1:max(y_m)+1,min(z_m)-1:max(z_m)+1)=1;

u=zeros(diff);
v=u;
w=u;

u(:)=U_nii.img(cropping==1);
v(:)=V_nii.img(cropping==1);
w(:)=W_nii.img(cropping==1);

%make nifti files of clipped hippocampis
u_nii=make_nii(u);
v_nii=make_nii(v);
w_nii=make_nii(w);


u_nii.hdr=U_nii.hdr;

u_nii.hdr.dime.dim(2:4)=size(u);

min_m_w=World(U_nii,min_m(1)-2,min_m(2)-2,min_m(3)-2);%matlab indices start at 1
max_m_w=World(U_nii,max_m(1),max_m(2),max_m(3));      %but sform assumes 0 !!YOU HAVE  CHANGED THE FUNCTIONS NOW!!

u_nii.hdr.hist.srow_x(4)=max(min_m_w(1),max_m_w(1));
u_nii.hdr.hist.srow_y(4)=min(min_m_w(2),max_m_w(2));
u_nii.hdr.hist.srow_z(4)=min(min_m_w(3),max_m_w(3));
u_nii.hdr.hist.sform_code=1;

v_nii.hdr=u_nii.hdr;
w_nii.hdr=u_nii.hdr;

imagesc(squeeze(w_nii.img(14,:,:)));

save_nii(u_nii,'sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz');
save_nii(v_nii,'sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz');
save_nii(w_nii,'sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz');




