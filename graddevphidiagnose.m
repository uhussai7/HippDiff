clear j_inds J_i J_j J_k

j_inds=find(isnan(graddev_phi_nonan_nii.img(:,:,:,9))==0);


size_j=size(graddev_phi_nonan_nii.img(:,:,:,2));


[J_i,J_j,J_k]=ind2sub(size_j,j_inds);



