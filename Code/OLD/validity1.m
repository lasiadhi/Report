clear all
clc

rho=1000;
g=9.8;
Tb=10;
Hmax=1;
h = [11; 10; 9.5; 8.5; 7.5; 6.5; 5.5; 4.5; 3.6; 3; 2.6; 6; 4; 3.2; 2.6; 2; 1.4; 0.8; 0.3; 0.5];

[N1 ,p]=size(h);
xmin=0;xmax=1150;
N=N1-1;
dx=(xmax-xmin)/N;

af = 2*pi/Tb;
x = xmin:dx:xmax;
% To determine k
k=zeros(N,1);
iter=50;kk=zeros(N1,1);
for i=1:N1
    for j=1:iter
        kk(1)=1;
        kk(j+1)=kk(j)-(g*kk(j)*tanh(kk(j)*h(i))-af^2)/(g*tanh(kk(j)*h(i))+g*h(i)*kk(j)*(sech(kk(j)*h(i)))^2);
    end
    
    k(i)=kk(iter);
end
%find delta when H=x^2(assume).
lambda=rho*g*pi/(8*Tb);
delta=zeros(N1,1);
for i=1:N1
delta(i)=4*x(i)^3*(1+(2*k(i)*h(i))/sinh(2*k(i)*h(i)))*lambda*(1/k(i));
end
del=delta;
%=============================================================
%get the values of H  from H(x)=x^2 to validate the value of H later.
%=======================================================
H2=x.^2;
H2(1)=Hmax;
% c = zeros(N1, 1);
% 
% for i = 1: N1
%     c(i) = (1+(2*k(i)*h(i))/sinh(2*k(i)*h(i)))*lambda/(k(i)*dx);
% end

for i=2:N1
    H2(i)=x(i)^2;
    Hmax=0.78*h(i);
    H2(i)=min(H2(i),Hmax);
end

%HH=H1;
%================================================
% Determine H from the model
%================================================
% A = zeros(N1);
% 
% % af^2 = g*k*tanh(k*h)
% %const = (1/8)*rho*g^(3/2);
% lambda = rho*g*pi/(8*Tb);
% 
% %{
% for i = 2: N1-1
%     for j=1:N1-1
%         A(i,j) =const*sqrt(h)*(1+((2*k(i)*h)/(sinh(1+2*k(i)*h))))*(1/dx)*(H(i)*H(i+1)-H(i)*H(i-1));
%     end
% end
% %}
% 
c = zeros(N1, 1);

for i = 1: N1
    c(i) = (1+(2*k(i)*h(i))/sinh(2*k(i)*h(i)))*lambda/(k(i)*dx);
end
% 
% for i = 1: N1-1
%     A(i, i) = c(i);
%     A(i+1, i) = -c(i);
% end
% A(N1, N1) = c(N1);
% 
% 
% % AH = delta
% delta=del;%right hand side vector. For this we ae taking this from estimated delta
% boundary=[1 N1];%boundary indices
% 
% %use of boundary conditions
% A(boundary,:)=0;
% A(:,boundary)=0;
% A(boundary,boundary)=speye(length(boundary),length(boundary));
% 
% H(1)=Hmax;
% delta(1)=H(1)^2;
% %delta(N1)=H(N1)^2;
% 
% % solve for H
% y = A\delta;
% 
% H = sqrt(y);

H1 = zeros(N1, 1);H=zeros(N1,1);
Hmax=1;
H(1)=Hmax;
H1(1) = H(1);
for i=2:N1
    H1(i) = (delta(i)*dx+c(i)*(H1(i-1))^2)/c(i);
    H1(i) = sqrt(H1(i));
    Hmax=0.78*h(i);

    H(i)=min(H1(i),Hmax);
end

figure;
plot(x,H,'*',x,H2,'-^');
xlabel('x');
ylabel('wave height comparsion')
legend('Approx H','Exact H')

figure;
subplot(1,2,1)
plot(x,H,'-*');
xlabel('x');
ylabel('wave height(Approx)')
subplot(1,2,2)
plot(x,H2,'-o');
xlabel('x');
ylabel('wave height(Exact)')