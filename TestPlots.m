%Put some test plots here
%--------------------------------------------------------------------------


%plot the actual hippocampus
figure;scatter3(x,y,z,[],u);
figure;scatter3(x,y,z,[],v);
figure;scatter3(x,y,z,[],w);
%--------------------------------------------------------------------------


%plot the unfolded "block" this is to demonstrate issue with the laplace
%fields not covering the whole (u,v) domain for all w values
figure;
subplot(2,2,1);
scatter3(u,v,w,[],y);
view(0,90);
zlim([0.75 1])
title('w slice=0.75 to 1 colormap=w');
xlabel('u');ylabel('v');

subplot(2,2,2);
scatter3(u,v,w,[],y);
view(0,90);
zlim([0.5 0.75])
title('w slice=0.5 to 0.75 colormap=w');
xlabel('u');ylabel('v');

subplot(2,2,3);
scatter3(u,v,w,[],y);
view(0,90);
zlim([0.25 0.5])
title('w slice=0.25 to 0.5 colormap=w');
xlabel('u');ylabel('v');

subplot(2,2,4);
scatter3(u,v,w,[],y);
view(0,90);
zlim([0 0.25])
title('w slice=0 to 0.25 colormap=w');
xlabel('u');ylabel('v');
%--------------------------------------------------------------------------


%scatter x(u,v) y(u,v) and z(u,v)
figure;
subplot(1,3,1);scatter(u,v,[],w);
title('x(u,v)');
subplot(1,3,2);scatter(u,v,[],y);
title('y(u,v)');
subplot(1,3,3);scatter(u,v,[],z);
title('z(u,v)');

figure;scatter(u,w,[],v);
xlabel('u');
%--------------------------------------------------------------------------


%scatteredInperpolant x(u,v) y(u,v) and z(u,v)
Nu=100; samplingu=0:1/(Nu-1):1;
Nv=100; samplingv=0:1/(Nv-1):1;
Nw=10; samplingw=0:1/(Nw-1):1;

[gu,gv,gw]=meshgrid(samplingu,samplingv,samplingw);

Xi=Fi_L(gu,gv,gw);
Yi=Fj_L(gu,gv,gw);
Zi=Fk_L(gu,gv,gw);

figure;
subplot(1,3,1);imagesc(flipud(squeeze(Xi(:,:,5))));
title('x(u,v)');
subplot(1,3,2);imagesc(flipud(squeeze(Yi(:,:,5))));
title('y(u,v)');
subplot(1,3,3);imagesc(flipud(squeeze(Zi(:,:,5))));
title('z(u,v)');
%--------------------------------------------------------------------------


