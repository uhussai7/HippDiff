%make outside hippo nan for commuting gradients
u_w=U_nii.img;
v_w=V_nii.img;
w_w=W_nii.img;

u_w(u_w==0)=NaN;
v_w(v_w==0)=NaN;
w_w(w_w==0)=NaN;

sz_U=size(U_nii.img);

%compute grad with grad_nonan
[grad_dev_phi_nonan(:,:,:,4),grad_dev_phi_nonan(:,:,:,1),grad_dev_phi_nonan(:,:,:,7)]=grad_nonan(u_w);
[grad_dev_phi_nonan(:,:,:,5),grad_dev_phi_nonan(:,:,:,2),grad_dev_phi_nonan(:,:,:,8)]=grad_nonan(v_w);
[grad_dev_phi_nonan(:,:,:,6),grad_dev_phi_nonan(:,:,:,3),grad_dev_phi_nonan(:,:,:,9)]=grad_nonan(w_w);

ww=isnan(grad_dev_phi_nonan)==0;

test_nii=make_nii(grad_dev_phi_nonan);
save_nii(test_nii,'test.nii.gz');
view_nii(test_nii);

%crop
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

grad_dev_phi_xyz_min=int16(WorldI(U_nii,min_xyz_w(1),min_xyz_w(2),min_xyz_w(3)));
grad_dev_phi_xyz_max=int16(WorldI(U_nii,max_xyz_w(1),max_xyz_w(2),max_xyz_w(3)));

grad_dev_phi_sz=size(grad_dev_phi_nonan);

grad_dev_phi_cropping=zeros(grad_dev_phi_sz);

grad_dev_phi_cropping(grad_dev_phi_xyz_min(1):grad_dev_phi_xyz_max(1),grad_dev_phi_xyz_min(2):grad_dev_phi_xyz_max(2),grad_dev_phi_xyz_min(3):grad_dev_phi_xyz_max(3),:)=1;

grad_dev_phi_diff=grad_dev_phi_xyz_max-grad_dev_phi_xyz_min+1;

grad_dev_phi_crop=zeros(grad_dev_phi_diff(1),grad_dev_phi_diff(2),grad_dev_phi_diff(3),grad_dev_phi_sz(4));

grad_dev_phi_crop(:)=grad_dev_phi_nonan(grad_dev_phi_cropping==1);

grad_dev_phi_crop_nii=make_nii(grad_dev_phi_crop);
grad_dev_phi_crop_nii.hdr=U_nii.hdr;
grad_dev_phi_crop_nii.hdr.dime.dim(1)=4;
grad_dev_phi_crop_nii.hdr.dime.dim(2:5)=size(grad_dev_phi_crop_nii.img);
grad_dev_phi_crop_nii.hdr.dime.pixdim(5)=1;

grad_dev_phi_crop_nii.hdr.hist.srow_x(4)=max(min_xyz_w(1),max_xyz_w(1));
grad_dev_phi_crop_nii.hdr.hist.srow_y(4)=min(min_xyz_w(2),max_xyz_w(2));
grad_dev_phi_crop_nii.hdr.hist.srow_z(4)=min(min_xyz_w(3),max_xyz_w(3));
grad_dev_phi_crop_nii.hdr.hist.sform_code=1;

%view_nii(grad_dev_phi_crop_nii);
save_nii(grad_dev_phi_crop_nii,'grad_dev_phi_crop.nii.gz');

clear grad_dev_phi_uvw;
vol=1;
for vol=1:9
    vol
    grad_dev_phi_uvw(:,:,:,vol) = Iuvw(grad_dev_phi_crop_nii,grad_dev_phi_crop(:,:,:,vol),grad_dev_phi_xyz_min,Xi,Yi,Zi);
end

figure;
for vol=1:9
    subplot(3,3,vol);imagesc(squeeze(grad_dev_phi_o_uvw(:,:,5,vol)));
end


