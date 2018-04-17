function xyz = World(nii,i,j,k)
indices=[i;j;k;1];
sform=zeros(4,4);
sform(1,:)=nii.hdr.hist.srow_x;
sform(2,:)=nii.hdr.hist.srow_y;
sform(3,:)=nii.hdr.hist.srow_z;
sform(4,:)=[0,0,0,1];
xyz=sform*indices;
end

