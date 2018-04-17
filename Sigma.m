%function d_vox = Sigma(i_un,j_un,k_un,Fi_L,Fj_L,Fk_L,U_nii,diff_nii)
function d_vox = Sigma(i_un,j_un,k_un)

global Fi_L;
global Fj_L;
global Fk_L;
global U_nii;
global diff_nii;


d_vox(1)=Fi_L(i_un,j_un,k_un);
d_vox(2)=Fj_L(i_un,j_un,k_un);
d_vox(3)=Fk_L(i_un,j_un,k_un);

%d_vox=World(U_nii,d_vox(1),d_vox(2),d_vox(3)); %could use full laplace fields also
%d_vox=WorldI(diff_nii,d_vox(1),d_vox(2),d_vox(3));


end

