%load all the relevant files

%load the cropped files
%uvw
U_nii=load_nii('sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz');
V_nii=load_nii('sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz');
W_nii=load_nii('sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz');
%diffusion
diff_nii=load_nii('test_diff_crop.nii.gz');

%set up the relevant interpolants
inds=find(U_nii.img>0);

[i_L,j_L,k_L]=ind2sub(size(U_nii.img),inds);
u=U_nii.img(inds);
v=V_nii.img(inds);
w=W_nii.img(inds);

imagesc(squeeze(W_nii.img(16,:,:)));

interp='linear';
extrap='none';
Fi_L=scatteredInterpolant(u,v,w,i_L,interp,extrap);
Fj_L=scatteredInterpolant(u,v,w,j_L,interp,extrap);
Fk_L=scatteredInterpolant(u,v,w,k_L,interp,extrap);

Fu=scatteredInterpolant(i_L,j_L,k_L,u,interp,extrap);
Fv=scatteredInterpolant(i_L,j_L,k_L,v,interp,extrap);
Fw=scatteredInterpolant(i_L,j_L,k_L,w,interp,extrap);




