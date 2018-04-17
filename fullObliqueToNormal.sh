#!/bin/bash

rfnc="../../../sourcedata/sub-899885/anat/sub-899885_T2w_original.nii.gz"
AP="sub-899885_T2w_space-Oblique_full_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz"
AP_out="sub-899885_T2w_space-full_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz"
PD="sub-899885_T2w_space-Oblique_full_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz"
PD_out="sub-899885_T2w_space-full_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz"
IO="sub-899885_T2w_space-Oblique_full_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz"
IO_out="sub-899885_T2w_space-full_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz"
invrs="oblique_to_T2w.xfm"
trans="../../../sourcedata/sub-899885/anat/T2w_to_oblique.xfm"

reg_transform -ref $rfnc -invAffine $trans $invrs
reg_resample -ref $rfnc -flo $AP -aff $invrs -res $AP_out -inter 0
reg_resample -ref $rfnc -flo $PD -aff $invrs -res $PD_out -inter 0
reg_resample -ref $rfnc -flo $IO -aff $invrs -res $IO_out -inter 0


