%quartz
rho=2660;
c=733;
k=8.4;
alpha=k/rho/c;

lx=4;
ly=4;
nx=40;
ny=40;
dx=lx/nx;
dy=ly/ny;
theta=0.5;

result2=zeros(nx+1,ny+1);
result4=zeros(nx+1,ny+1);
result6=zeros(nx+1,ny+1);

d=0.25;
dt=580;
t=580000;
nt=t/dt;

u=zeros(nx+1,ny+1);
u_n=zeros(nx+1,ny+1);

fx=alpha*dt/dx^2;
fy=alpha*dt/dy^2;

t0=300;
tm=10;

u_n=u_n+t0;

n=(nx+1)*(ny+1);
A=zeros(n,n);
b=zeros(n,1);

m=@ (i,j) (j-1)*(nx+1)+i;
j=1;
for i=1:nx+1
   p=m(i,j);
   A(p,p)=1;
end

for j=2:ny
   i=1;
   p=m(i,j);
   A(p,p)=1;
   for i=2:nx
       p=m(i,j);
       A(p, m(i,j-1)) = -theta*fy;
       A(p, m(i-1,j)) = -theta*fx;
       A(p, p) = 1 + 2*theta*(fx+fy);
       A(p, m(i+1,j)) = -theta*fx;
       A(p, m(i,j+1)) = -theta*fy;
   end
   i=nx+1;
   p=m(i,j);
   A(p,p)=1;
end
j = ny+1;
for i=1:nx+1
   p=m(i,j);
   A(p,p)=1;
end

T=@ (te) t0+tm*sin(2*pi/24/3600*te); 
for n=1:nt
    j=1;
    for i=1:nx+1
        p=m(i,j);
        temp=T((n-1)*dt);
        b(p)=temp;
    end
    for j=2:ny
        i=1;
        p=m(i,j);
        b(p)=t0;
        for i=2:nx
            p = m(i,j);
            b(p)=u_n(i,j)+(1-theta)*(fx*(u_n(i+1,j)-2*u_n(i,j)+u_n(i-1,j))+fy*(u_n(i,j+1)-2*u_n(i,j)+u_n(i,j-1)));
        end
        i=nx+1;
        p=m(i,j);
        b(p)=t0;
    end
    j=ny+1;
    for i=1:nx+1
        p=m(i,j);
        b(p)=t0;
    end
    c=A\b;
    for i=1:nx+1
        for j=1:ny+1
            u(i,j) = c(m(i,j));
        end
    end
    u_n=u;
    if n==300
        result2=u;
    elseif n==600
        result4=u;
    elseif n==900
        result6=u;
    end
    surf(u);
    axis([0 50 0 50 285 315])
    pause(0.01);
end



