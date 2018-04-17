diff_uvw_nii=make_nii(diff_uvw);
save_nii(diff_uvw_nii,'diff_uvw.nii.gz');

grad_dev_phi_o_uvw_nii=make_nii(grad_dev_phi_o_uvw);
save_nii(grad_dev_phi_o_uvw_nii,'grad_dev_phi_o_uvw.nii.gz')

brain_mask_nii=make_nii(brain_mask);
save_nii(brain_mask_nii,'nodif_brain_mask.nii.gz');

grad_dev_uvw_nii=make_nii(grad_dev_uvw);
save_nii(grad_dev_uvw_nii,'grad_dev_uvw.nii.gz')

roi_uvw_nii=make_nii(Iout);
save_nii(roi_uvw_nii,'t2_uvw.nii.gz');