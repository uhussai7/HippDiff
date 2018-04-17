%Create full oblique nifti files
%Apply inverse transform to these with nifty reg

full_AP_nii=head2fullnii(origheader,Laplace_AP,sz,origsz,idxgm,cropping);
full_IO_nii=head2fullnii(origheader,Laplace_IO,sz,origsz,idxgm,cropping);
full_PD_nii=head2fullnii(origheader,Laplace_PD,sz,origsz,idxgm,cropping);

save_nii(full_AP_nii,'sub-899885_T2w_space-Oblique_full_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz');
save_nii(full_IO_nii,'sub-899885_T2w_space-Oblique_full_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz');
save_nii(full_PD_nii,'sub-899885_T2w_space-Oblique_full_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz');

clear full_AP_nii;
clear full_IO_nii;
clear fill_PD_nii;