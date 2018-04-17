diff_img=diff_nii.img(:,:,:,1);
[jd,id,kd]=meshgrid(1:30,1:22,1:28); %notice how x and y are flipped here and below in the query
g1=diff_img(10,10,10);
g2=diff_img(11,10,10);
ginterp=interp3(jd,id,kd,diff_img,10.5,10,10);

imagesc(squeeze(diff_img(:,:,10)));
figure;imagesc(squeeze(diff_img(:,13,:)));

up=2;
for l=1:60*up
    for m=1:52*up
        diff_img_up_up(l,m)=interp3(jd,id,kd,diff_img,l/(2*up),15,m/(2*up),'cubic'); %how x and y are flipped here
    end
end

