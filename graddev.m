%make outside hippo nan for commuting gradients
u_w=U_nii.img;
v_w=V_nii.img;
w_w=W_nii.img;

u_w(u_w==0)=NaN;
v_w(v_w==0)=NaN;
w_w(w_w==0)=NaN;

sz_U=size(U_nii.img);

%% compute grad with grad_nonan

[graddev_phi_nonan(:,:,:,2),graddev_phi_nonan(:,:,:,1),graddev_phi_nonan(:,:,:,3)]=grad_nonan(u_w);
[graddev_phi_nonan(:,:,:,5),graddev_phi_nonan(:,:,:,4),graddev_phi_nonan(:,:,:,6)]=grad_nonan(v_w);
[graddev_phi_nonan(:,:,:,8),graddev_phi_nonan(:,:,:,7),graddev_phi_nonan(:,:,:,9)]=grad_nonan(w_w);

graddev_phi_nonan_nii=make_nii(graddev_phi_nonan);

graddev_phi_nonan_nii.hdr=U_nii.hdr;


graddev_phi_nonan_nii.hdr.dime.dim(1)=4;
graddev_phi_nonan_nii.hdr.dime.dim(2:5)=size(graddev_phi_nonan);
graddev_phi_nonan_nii.hdr.dime.pixdim(5)=1;

save_nii(graddev_phi_nonan_nii,'grad_dev_crop_phi_nonan.nii.gz');


%% regular gradientcompute gradient
[graddev_phi(:,:,:,2),graddev_phi(:,:,:,1),graddev_phi(:,:,:,3)]=gradient(u_w);
[graddev_phi(:,:,:,5),graddev_phi(:,:,:,4),graddev_phi(:,:,:,6)]=gradient(v_w);
[graddev_phi(:,:,:,8),graddev_phi(:,:,:,7),graddev_phi(:,:,:,9)]=gradient(w_w);


graddev_phi_nii=make_nii(graddev_phi);

graddev_phi_nii.hdr=graddev_phi_nonan_nii.hdr;


save_nii(graddev_phi_nii,'grad_dev_crop_phi.nii.gz');



 