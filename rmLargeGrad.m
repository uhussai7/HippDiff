function A = rmLargeGrad(X,Y,Z)
%RMLARGEGRAD Summary of this function goes here
%   Detailed explanation goes here
mag=sqrt(X.^2+Y.^2+Z.^2);
A=mag>0.01;
imagesc(squeeze(mag(:,53,:)));
end

