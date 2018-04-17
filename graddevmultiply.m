size_gd=size(grad_dev_uvw);
for u_in=1:size_gd(1)
    for v_in=1:size_gd(2)
        for w_in=1:size_gd(3)
            J_o=zeros(3,3);
            J_phi=zeros(3,3);
            J_o(1,1)=1+grad_dev_uvw(u_in,v_in,w_in,1);
            J_o(1,2)=grad_dev_uvw(u_in,v_in,w_in,4);
            J_o(1,3)=grad_dev_uvw(u_in,v_in,w_in,7);
            
            J_o(2,1)=grad_dev_uvw(u_in,v_in,w_in,1+1);
            J_o(2,2)=1+grad_dev_uvw(u_in,v_in,w_in,4+1);
            J_o(2,3)=grad_dev_uvw(u_in,v_in,w_in,7+1);
            
            J_o(3,1)=grad_dev_uvw(u_in,v_in,w_in,1+2);
            J_o(3,2)=grad_dev_uvw(u_in,v_in,w_in,4+2);
            J_o(3,3)=1+grad_dev_uvw(u_in,v_in,w_in,7+2);
            
            
            J_phi(1,1)=grad_dev_phi_uvw(u_in,v_in,w_in,1);
            J_phi(1,2)=grad_dev_phi_uvw(u_in,v_in,w_in,4);
            J_phi(1,3)=grad_dev_phi_uvw(u_in,v_in,w_in,7);
            
            J_phi(2,1)=grad_dev_phi_uvw(u_in,v_in,w_in,1+1);
            J_phi(2,2)=grad_dev_phi_uvw(u_in,v_in,w_in,4+1);
            J_phi(2,3)=grad_dev_phi_uvw(u_in,v_in,w_in,7+1);
            
            J_phi(3,1)=grad_dev_phi_uvw(u_in,v_in,w_in,1+2);
            J_phi(3,2)=grad_dev_phi_uvw(u_in,v_in,w_in,4+2);
            J_phi(3,3)=grad_dev_phi_uvw(u_in,v_in,w_in,7+2);
            
            %J_phi_o=J_phi*J_o-eye(3);
            
            J_phi_o=J_phi;
            
            determinant(u_in,v_in,w_in)=det(J_o);
            
            determinant1(u_in,v_in,w_in)=det(J_phi_o+eye(3));
            
            
            
            if(isnan(det(J_phi_o))==0 & det(J_phi_o)~=0.0 & det(J_phi_o)~=-1)
                brain_mask(u_in,v_in,w_in)=1.0;
                [R U V]=poldecomp(J_phi_o);
                J_phi_o=R-eye(3);
            else
                brain_mask(u_in,v_in,w_in)=0.0;
            end
            
            
            
            grad_dev_phi_o_uvw(u_in,v_in,w_in,1)=J_phi_o(1,1);
            grad_dev_phi_o_uvw(u_in,v_in,w_in,4)=J_phi_o(1,2);
            grad_dev_phi_o_uvw(u_in,v_in,w_in,7)=J_phi_o(1,3);
            
            grad_dev_phi_o_uvw(u_in,v_in,w_in,1+1)=J_phi_o(2,1);
            grad_dev_phi_o_uvw(u_in,v_in,w_in,4+1)=J_phi_o(2,2);
            grad_dev_phi_o_uvw(u_in,v_in,w_in,7+1)=J_phi_o(2,3);
            
            grad_dev_phi_o_uvw(u_in,v_in,w_in,1+2)=J_phi_o(3,1);
            grad_dev_phi_o_uvw(u_in,v_in,w_in,4+2)=J_phi_o(3,2);
            grad_dev_phi_o_uvw(u_in,v_in,w_in,7+2)=J_phi_o(3,3);
            
            
        end
    end
end