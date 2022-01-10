function [alpha] = alpha(i,dx)
%quartz
rho1=2660;
c1=733;
k1=8.4;
alpha1=k1/rho1/c1;
%granite
rho2=2750;
c2=890;
k2=2.3;
alpha2=k2/rho2/c2;
%limestone
rho3=2300;
c3=900;
k3=1.3;
alpha3=k3/rho3/c3;
%clay
rho4=1450;
c4=880;
k4=1.28;
alpha4=k4/rho4/c4;

x=(i-1)*dx;
alph1=0;
if x>=0 && x<0.2
    alph1=alpha1;
elseif x>=0.2 && x<0.4
    alph1=alpha3;
elseif x>=0.4 && x<0.6
    alph1=alpha2;
elseif x>=0.6 && x<4
    alph1=alpha4;
end

x=i*dx;
alph2=0;
if x>=0 && x<0.2
    alph2=alpha1;
elseif x>=0.2 && x<0.4
    alph2=alpha3;
elseif x>=0.4 && x<0.6
    alph2=alpha2;
elseif x>=0.6 && x<4
    alph2=alpha4;
end
alpha=(alph1+alph2)/2;
end

