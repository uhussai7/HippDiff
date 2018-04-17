function ret1 = Unfld2Native(u_q,v_q,w_q,TRIxyz_c,TRIuvw_c)

% global TRIxyz
% global TRIxyz_c
% global TRIuvw
% global TRIuvw_c

query=[u_q;v_q;w_q;1];

ID=pointLocation(TRIuvw_c,[u_q,v_q,w_q]);

if(isnan(ID)==1)
    %disp(w_q);
    ret1(1)=NaN;
    ret1(2)=NaN;
    ret1(3)=NaN;
    return
end

B = cartesianToBarycentric(TRIuvw_c,ID,[u_q,v_q,w_q]);

C =barycentricToCartesian(TRIxyz_c,ID,[B(1),B(2),B(3),B(4)]);

ret1=C;

end




