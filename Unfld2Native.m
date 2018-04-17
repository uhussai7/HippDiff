function ret1 = Unfld2Native(u_q,v_q,w_q,TRIuvw)

% global TRIuvw
global u v w i_L j_L k_L
global Hippo_alpha
global TRIxyz
global TRIxyz_c

%{
u_q=0.5;
v_q=0.5;
w_q=0.5;
%}
query=[u_q;v_q;w_q;1];

ID=pointLocation(TRIuvw,[u_q,v_q,w_q]);

if(isnan(ID)==1)
    %disp(w_q);
    ret1(1)=NaN;
    ret1(2)=NaN;
    ret1(3)=NaN;
    return
end

B = cartesianToBarycentric(TRIuvw,ID,[u_q,v_q,w_q]);

C =barycentricToCartesian(TRIxyz_c,ID,[B(1),B(2),B(3),B(4)]);

ret1=C;

%ID2=pointLocation(TRIxyz_c,C);


%{
Tind=TRIuvw.ConnectivityList(ID,:);

for m=1:4
   U(1,m)=u(Tind(m));
   U(2,m)=v(Tind(m));
   U(3,m)=w(Tind(m));
   U(4,m)=1;
   N(1,m)=i_L(Tind(m));
   N(2,m)=j_L(Tind(m));
   N(3,m)=k_L(Tind(m));
   N(4,m)=1;
end
   
Uinv=inv(U);

ret=N*Uinv*query;

%{
if(isnan(ret(1))==0 & isnan(ret(2))==0 & isnan(ret(3))==0)
    if(ID~=ID2)
        ret1(1)=NaN;
        ret1(2)=NaN;
        ret1(3)=NaN;
        return
    end
end
%}

ret1(1)=ret(1);
ret1(2)=ret(2);
ret1(3)=ret(3);
%}
end




