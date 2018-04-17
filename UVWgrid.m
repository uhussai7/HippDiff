%construct uvw grid and pull diffusion data
Nu=64;
Nv=64;
Nw=64;

samplingu=0:1/(Nu-1):1;
samplingv=0:1/(Nu-1):1;
samplingw=0:1/(Nu-1):1;

[Ug,Vg,Wg]=meshgrid(samplingu,samplingv,samplingw);

I_L=Fi_L(Ug,Vg,Wg);
J_L=Fj_L(Ug,Vg,Wg);
K_L=Fk_L(Ug,Vg,Wg);


imagesc(squeeze(I_L(:,:,32)))