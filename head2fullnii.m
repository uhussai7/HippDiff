function nii = head2fullnii(header,Laplace,sz,origsz,idxgm,cropping)

 
 toEmbed=zeros(sz);
 toEmbed(idxgm)=Laplace;
 
 full_img=zeros(origsz);
 full_img(cropping==1)=toEmbed;
 nii=make_nii(full_img);
 nii.hdr=header.original.hdr;
 nii.hdr.dime.datatype=64;

end

