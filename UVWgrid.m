su=0;
eu=1;

sv=0;
ev=1;

sw=0;
ew=1.0;

clear samplingu samplingv samplingw;
clear gu gv gw;
Nu=100; samplingu=su:(eu-su)/(Nu-1):eu;
Nv=100; samplingv=sv:(ev-sv)/(Nv-1):ev;
Nw=10; samplingw=sw:(ew-sw)/(Nw-1):ew;

[gu,gv,gw]=meshgrid(samplingu,samplingv,samplingw);


clear Xi Yi Zi;
for int_u=1:Nu
    for int_v=1:Nv
        for int_w=1:Nw
            r_q=Unfld2Native(samplingu(int_u),samplingv(int_v),samplingw(int_w),TRIxyz_c,TRIuvw_c);
            Xi(int_u,int_v,int_w)=r_q(1);
            Yi(int_u,int_v,int_w)=r_q(2);
            Zi(int_u,int_v,int_w)=r_q(3);
        end
    end
end

imagesc(squeeze(Zi(:,:,4)))


