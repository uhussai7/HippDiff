%load nifti files
u_nii=load_nii('sub-899885_T2w_space-crop_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz');


u_nii.img(u_nii.img==0)=NaN;
u_up_img=interp3(u_nii.img);

imagesc(squeeze(u_up_img(:,:,40)));

figure;imagesc(squeeze(u_nii.img(:,:,20)));

gradphi=load_nii('grad_dev_crop_phi.nii.gz');