
%convert into 9 volume image
size_graddev=size(U_nii.img);
size_graddev(4)=9;



%crop grad dev
Usize=size(U_nii.img);
hipbox=zeros(6,4);
hipbox(:,4)=1;
hipbox(1,1)=1;hipbox(3,2)=1;hipbox(5,3)=1;
hipbox(2,1)=Usize(1);hipbox(4,2)=Usize(2);hipbox(6,3)=Usize(3);

for hp=1:6
    hipbox(hp,:)=World(U_nii,hipbox(hp,1),hipbox(hp,2),hipbox(hp,3));
end

for hp=1:6
    hipbox(hp,:)=(((WorldI(grad_dev_nii,hipbox(hp,1),hipbox(hp,2),hipbox(hp,3)))));
end


hipbox_int=int16(round(hipbox));


crop=false(size(grad_dev_nii.img));
crop(hipbox_int(1,1):hipbox_int(2,1),hipbox_int(3,2):hipbox_int(4,2),hipbox_int(5,3):hipbox_int(6,3),:)=true;

grad_dev_crop=zeros(hipbox_int(2,1)-hipbox_int(1,1)+1,hipbox_int(4,2)-hipbox_int(3,2)+1,hipbox_int(6,3)-hipbox_int(5,3)+1,9);

grad_dev_crop(:)=grad_dev_nii.img(crop==1);

grad_dev_crop_nii=make_nii(grad_dev_crop);

grad_dev_crop_nii.hdr=grad_dev_nii.hdr;
grad_dev_crop_nii.hdr.dime.dim(2:5)=size(grad_dev_crop_nii.img);


for hp=1:6
    hipbox(hp,:)=World(grad_dev_nii,hipbox(hp,1),hipbox(hp,2),hipbox(hp,3));
end

grad_dev_crop_nii.hdr.hist.srow_x(4)=max(hipbox(1,1),hipbox(2,1));
grad_dev_crop_nii.hdr.hist.srow_y(4)=min(hipbox(3,2),hipbox(4,2));
grad_dev_crop_nii.hdr.hist.srow_z(4)=min(hipbox(5,3),hipbox(6,3));

save_nii(grad_dev_crop_nii,'grad_dev_crop.nii.gz');
