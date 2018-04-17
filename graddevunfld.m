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

grad_dev_xyz_min=int16(WorldI(grad_dev_nii,min_xyz_w(1),min_xyz_w(2),min_xyz_w(3)));
grad_dev_xyz_max=int16(WorldI(grad_dev_nii,max_xyz_w(1),max_xyz_w(2),max_xyz_w(3)));

grad_dev_sz=grad_dev_nii.hdr.dime.dim(2:5);

grad_dev_cropping=zeros(grad_dev_sz);

grad_dev_cropping(grad_dev_xyz_min(1):grad_dev_xyz_max(1),grad_dev_xyz_min(2):grad_dev_xyz_max(2),grad_dev_xyz_min(3):grad_dev_xyz_max(3),:)=1;

grad_dev_diff=grad_dev_xyz_max-grad_dev_xyz_min+1;

grad_dev_crop=zeros(grad_dev_diff(1),grad_dev_diff(2),grad_dev_diff(3),grad_dev_sz(4));

grad_dev_crop(:)=grad_dev_nii.img(grad_dev_cropping==1);

grad_dev_crop_nii=make_nii(grad_dev_crop);
grad_dev_crop_nii.hdr=grad_dev_nii.hdr;
grad_dev_crop_nii.hdr.dime.dim(2:5)=size(grad_dev_crop_nii.img);

grad_dev_crop_nii.hdr.hist.srow_x(4)=max(min_xyz_w(1),max_xyz_w(1));
grad_dev_crop_nii.hdr.hist.srow_y(4)=min(min_xyz_w(2),max_xyz_w(2));
grad_dev_crop_nii.hdr.hist.srow_z(4)=min(min_xyz_w(3),max_xyz_w(3));
grad_dev_crop_nii.hdr.hist.sform_code=1;

save_nii(grad_dev_crop_nii,'grad_dev_crop.nii.gz');


clear grad_dev_uvw;
vol=1;
for vol=1:9
    vol
    grad_dev_uvw(:,:,:,vol) = Iuvw(grad_dev_crop_nii,grad_dev_crop(:,:,:,vol),grad_dev_xyz_min,Xi,Yi,Zi);
end

figure;
for vol=1:9
    subplot(3,3,vol);imagesc(squeeze(grad_dev_uvw(:,:,5,vol)));
end

% test_i=20;
% test_j=12;
% test_k=8;
% 
% grad_dev_nii.img(grad_dev_xyz_min(1)+test_i-1,grad_dev_xyz_min(2)+test_j-1,grad_dev_xyz_min(3)+test_k-1)
% grad_dev_crop(test_i,test_j,test_k)