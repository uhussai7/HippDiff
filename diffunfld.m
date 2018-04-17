%build the box first
%convert box coordinates to world coordinates

buff=World(U_nii,min_xyz(1),0,0);
min_xyz_w(1)=buff(1);

buff=World(U_nii,0,min_xyz(2),0);
min_xyz_w(2)=buff(2);

buff=World(U_nii,0,0,min_xyz(3));
min_xyz_w(3)=buff(3);

buff=World(U_nii,max_xyz(1),0,0);
max_xyz_w(1)=buff(1);

buff=World(U_nii,0,max_xyz(2),0);
max_xyz_w(2)=buff(2);

buff=World(U_nii,0,0,max_xyz(3));
max_xyz_w(3)=buff(3);

diffxyz_min=int16(WorldI(diff_full_nii,min_xyz_w(1),min_xyz_w(2),min_xyz_w(3)));
diffxyz_max=int16(WorldI(diff_full_nii,max_xyz_w(1),max_xyz_w(2),max_xyz_w(3)));

diff_full_sz=diff_full_nii.hdr.dime.dim(2:5);

diff_cropping=zeros(diff_full_sz);

diff_cropping(diffxyz_min(1):diffxyz_max(1),diffxyz_min(2):diffxyz_max(2),diffxyz_min(3):diffxyz_max(3),:)=1;

diff_diff=diffxyz_max-diffxyz_min+1;

diff_crop=zeros(diff_diff(1),diff_diff(2),diff_diff(3),diff_full_sz(4));

diff_crop(:)=diff_full_nii.img(diff_cropping==1);

diff_crop_nii=make_nii(diff_crop);
diff_crop_nii.hdr=diff_full_nii.hdr;
diff_crop_nii.hdr.dime.dim(2:5)=size(diff_crop);

diff_crop_nii.hdr.hist.srow_x(4)=max(min_xyz_w(1),max_xyz_w(1));
diff_crop_nii.hdr.hist.srow_y(4)=min(min_xyz_w(2),max_xyz_w(2));
diff_crop_nii.hdr.hist.srow_z(4)=min(min_xyz_w(3),max_xyz_w(3));
diff_crop_nii.hdr.hist.sform_code=1;

save_nii(diff_crop_nii,'test_diff_crop.nii.gz');



diff_sum= sum(diff_crop,4);
diff_sum_nii=make_nii(diff_sum);
diff_sum_nii.hdr=diff_crop_nii.hdr;
diff_sum_nii.hdr.dime.dim(5)=1;
save_nii(diff_sum_nii,'test_diff_sum.nii.gz');

diff_sum_uvw=Iuvw(diff_crop_nii,diff_sum,diffxyz_min,Xi,Yi,Zi);

figure;imagesc(squeeze(diff_sum_uvw(:,:,4)))

for vol=1:diff_full_sz(4)
    vol
    diff_uvw(:,:,:,vol)=Iuvw(diff_crop_nii,diff_crop(:,:,:,vol),diffxyz_min,Xi,Yi,Zi);
end
