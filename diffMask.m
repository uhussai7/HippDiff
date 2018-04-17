diff_nii=load_nii('data.nii.gz'); %remember to change directory

laplace_nii=load_untouch_header_only('sub-899885_T2w_space-Oblique_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz');

T2_ni=load_untouch_header_only('sub-899885_T2w_original.nii.gz');



bigsz=size(cropping);
world_min=World(laplace_nii,1,1,1);
world_max=World(laplace_nii,sz(1),sz(2),sz(3));
world_x_max
world_y_min
world_y_max
world_z_min
world_z_max