%test Iuvw with U_nii

Nu=200; samplingu=0:1/(Nu-1):1;
Nv=200; samplingv=0:1/(Nv-1):1;
Nw=10; samplingw=0:1/(Nw-1):1;

[gu,gv,gw]=meshgrid(samplingu,samplingv,samplingw);

Xi=Fi_L(gu,gv,gw);
Yi=Fj_L(gu,gv,gw);
Zi=Fk_L(gu,gv,gw);

testT2=Iuvw(U_nii,Xi,Yi,Zi);


figure;imagesc(squeeze(testT2(:,:,5)))