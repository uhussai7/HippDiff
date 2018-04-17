%load diffusion data, remember you have to change dir manually
diff_full_nii=load_untouch_nii('data.nii.gz');

%get diffusion voxel coordinates of cropping box boununding planes
diffxyz_min=WorldI(diff_full_nii,min_m_w(1),min_m_w(2),min_m_w(3));
diffxyz_max=WorldI(diff_full_nii,max_m_w(1),max_m_w(2),max_m_w(3));

diff_full_sz=diff_full_nii.hdr.dime.dim(2:5);

diff_cropping=zeros(diff_full_sz);

diff_cropping(diffxyz_min(1)+1:diffxyz_max(1)+1,diffxyz_min(2)+1:diffxyz_max(2)+1,diffxyz_min(3)+1:diffxyz_max(3)+1,:)=1;

diff_diff=diffxyz_max-diffxyz_min+1;

diff_crop=zeros(diff_diff(1),diff_diff(2),diff_diff(3),diff_full_sz(4));

diff_crop(:)=diff_full_nii.img(diff_cropping==1);

diff_crop_nii=make_nii(diff_crop);
diff_crop_nii.hdr=diff_full_nii.hdr;
diff_crop_nii.hdr.dime.dim(2:5)=size(diff_crop);

diff_crop_nii.hdr.hist.srow_x(4)=max(min_m_w(1),max_m_w(1));
diff_crop_nii.hdr.hist.srow_y(4)=min(min_m_w(2),max_m_w(2));
diff_crop_nii.hdr.hist.srow_z(4)=min(min_m_w(3),max_m_w(3));
diff_crop_nii.hdr.hist.sform_code=1;

save_nii(diff_crop_nii,'test_diff_crop.nii.gz');

diff_sum= sum(diff_crop,4);
diff_sum_nii=make_nii(diff_sum);
diff_sum_nii.hdr=diff_crop_nii.hdr;
diff_sum_nii.hdr.dime.dim(5)=1;
save_nii(diff_sum_nii,'test_diff_sum.nii.gz');