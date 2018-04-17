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
graddev_phi_nonan_nii=load_untouch_nii('grad_dev_crop_phi_nonan.nii.gz');



%set up the relevant interpolants
inds=find(U_nii.img>0);

global u v w i_L j_L k_L;
[i_L,j_L,k_L]=ind2sub(size(U_nii.img),inds);
u=U_nii.img(inds);
v=V_nii.img(inds);
w=W_nii.img(inds);

global Hippo_alpha;
Hippo_alpha=alphaShape(i_L,j_L,k_L);
spc=alphaSpectrum(Hippo_alpha);
Hippo_alpha.Alpha=min(spc);

global uvw_alpha;
uvw_alpha=alphaShape(u,v,w,'HoleThreshold',10000000)

%Hippo_alpha.HoleThreshold=20000000000;

%setup triangulation using alphaShape
global TRIuvw
global TRIxyz
global TRIuvw_c %these are cut triangulutions
global TRIxyz_c %meaning only on the hippo campus

TRIuvw=delaunayTriangulation(u,v,w);
TRIxyz=delaunayTriangulation(i_L,j_L,k_L);

%get center points of triangulation
IC = incenter(TRIuvw);
szic=size(IC);
%go through center points - remove triangles that are outside alpha shape
clear cnct;
ic_i2=1;
for ic_i=1:szic(1)
    if(inShape(uvw_alpha,IC(ic_i,1),IC(ic_i,2),IC(ic_i,3))==1)
        cnct(ic_i2,:)=TRIuvw.ConnectivityList(ic_i,:);
        ic_i2=ic_i2+1;
    end
end

clear TRIuvw_c;
clear TRIxyz_c
TRIuvw_c=triangulation(cnct,TRIuvw.Points);
TRIxyz_c=triangulation(cnct,TRIxyz.Points);

