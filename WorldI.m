function ijk = WorldI(nii,x_w,y_w,z_w)
world=[x_w;y_w;z_w;1];
sform=zeros(4,4);
sform(1,:)=nii.hdr.hist.srow_x;
sform(2,:)=nii.hdr.hist.srow_y;
sform(3,:)=nii.hdr.hist.srow_z;
sform(4,:)=[0,0,0,1];
sforminv=inv(sform);
%ijk=round(sforminv*world,0);
ijk=int16(sforminv*world);
end

