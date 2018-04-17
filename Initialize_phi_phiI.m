%load all the relevant files

%load the cropped files
%uvw
global U_nii;
U_nii=load_untouch_nii('sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz');

global V_nii;
V_nii=load_untouch_nii('sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz');

global W_nii;
W_nii=load_untouch_nii('sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz');

%diffusion
global diff_nii;
diff_nii=load_untouch_nii('test_diff_crop.nii.gz');

%T2
global T2_nii;
T2_nii=load_untouch_nii('..\..\..\sourcedata\sub-899885\anat\sub-899885_T2w_original.nii.gz');
T2_p_nii=load_untouch_nii('sub-899885_T2w_space-full_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz');

%graddev
grad_dev_nii=load_untouch_nii('..\..\..\Diffusion\grad_dev.nii.gz');
grad_dev_crop_nii=load_untouch_nii('grad_dev_crop.nii.gz');


%set up the relevant interpolants
inds=find(U_nii.img>0);
M=U_nii.img>0;

global u v w i_L j_L k_L;
[i_L,j_L,k_L]=ind2sub(size(U_nii.img),inds);
u=U_nii.img(inds);
v=V_nii.img(inds);
w=W_nii.img(inds);

M=double(M);
m=double(M(inds));

interp='linear';
extrap='none';
global Fi_L;
Fi_L=scatteredInterpolant(u,v,w,i_L,interp,extrap);

global Fj_L;
Fj_L=scatteredInterpolant(u,v,w,j_L,interp,extrap);

global Fk_L;
Fk_L=scatteredInterpolant(u,v,w,k_L,interp,extrap);

global FM;
FM=scatteredInterpolant(i_L,j_L,k_L,m,'nearest',extrap);


Fu=scatteredInterpolant(i_L,j_L,k_L,u,interp,extrap);
Fv=scatteredInterpolant(i_L,j_L,k_L,v,interp,extrap);
Fw=scatteredInterpolant(i_L,j_L,k_L,w,interp,extrap);

global Hippo_alpha;
Hippo_alpha=alphaShape(i_L,j_L,k_L);
spc=alphaSpectrum(Hippo_alpha);
Hippo_alpha.Alpha=min(spc);

global uvw_alpha;
uvw_alpha=alphaShape(u,v,w,'HoleThreshold',10000000)


%Hippo_alpha.HoleThreshold=20000000000;
