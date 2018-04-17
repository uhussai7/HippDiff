%create the unfolded T2 image

%extract region of interest
roi=zeros(max(i_L)-min(i_L)+3,max(j_L)-min(j_L)+3,max(k_L)-min(k_L)+3);
roi(:)=T2_nii.img(boundbox);
roi(:)=U_nii.img(boundbox);

roi_nii=make_nii(roi);
roi_nii.hdr=T2_nii.hdr;
roi_nii.hdr.dime.dim(2:4)=size(roi);

roi_nii.hdr.hist.srow_x(4)=max(min_xyz_w(1),max_xyz_w(1));
roi_nii.hdr.hist.srow_y(4)=min(min_xyz_w(2),max_xyz_w(2));
roi_nii.hdr.hist.srow_z(4)=min(min_xyz_w(3),max_xyz_w(3));
roi_nii.hdr.hist.sform_code=1;


view_nii(roi_nii);

save_nii(roi_nii,'roi.nii.gz');
view_nii(V_nii);

Iout = Iuvw(roi_nii,roi,min_xyz,Xi,Yi,Zi);

figure;
for temp=2:Nw-1
    subplot(3,3,temp-1);imagesc(squeeze(Iout(:,:,temp)));
    title(temp);
    %pause(0.5);
end

figure;imagesc(squeeze(Iout(:,:,5)));
