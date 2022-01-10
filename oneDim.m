axis([0 400 285 315]);

L=4;
T=100000;
Nx=400;
D=100000/4;
dx=L/Nx;
dt=D*dx^2;
Nt=40000;
T0=300;
Tm=10;
theta=0.5;

bound0= @(t) T0+Tm*sin(2*pi/24/3600*t); 

result=zeros(Nx+1,Nt+1);
for i=1:Nx+1
    result(i,1)=T0;
end

A=zeros(Nx+1,Nx+1);
A(1,1)=1;
A(Nx+1,Nx+1)=1;
b=zeros(Nx+1,1);
for i=2:Nx
   A(i,i)= 1+theta*D*(alpha(i,dx)+alpha(i-1,dx));
   A(i,i-1)=-theta*D*alpha(i-1,dx);
   A(i,i+1)=-theta*D*alpha(i,dx);
end

for n=2:Nt+1
    b(1)=bound0((n-1)*dt);
    b(Nx+1)=T0;
    for i=2:Nx
        b(i)=result(i,n-1)+(1-theta)*D*(alpha(i,dx)*(result(i+1,n-1)-result(i,n-1))-alpha(i-1,dx)*(result(i,n-1)-result(i-1,n-1)));
    end
    c=A\b;
    result(:,n)=c;
    if rem(n,100)==0
        p = plot(c);
        axis([0 450 285 315]);
        pause(0.01);
        delete(p);
    end
end

