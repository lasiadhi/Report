g = 9.8;        % m/s2
rho = 1000;     % kg/m3
%h = [0; 0.3; 0.8; 1.4; 2.0; 2.6; 3.2; 4.0; 4.8; 2.6; 3.0; 3.6; 4.5; 5.5; 6.5; 7.5; 8.5; 9.5; 10; 11];
h = [3.0; 3.6; 4.5; 5.5; 6.5; 7.5; 8.5; 9.5; 10; 11];

Hmax=2;xmax=2;
% to get the value of number of subinterval
[N1 ,N2] = size(h);

% N number of subinterval
N = N1-1;

% Boundary Condition
H = zeros(N1, 1);
H(1) = 0;
H(N1) = Hmax;
%break
% mesh size
xmin = 0;
dx = (xmax - xmin)/N;


% af: angular fruquency
Tb=1;
af = 2*pi/Tb;

% Initial vector of wave number

% get k
% k0 = 0;         %%%%%%%%%%% need to change %%%%%%%%%%
%f1 = @(k)g*k*tanh(k*h)-af^2;
%ff1 = @(k)g*tanh(k*h)+g*h*k*(sech(k*h)).^2;
% k = ones(N1, 1);
% 
% 
% k_old = zeros(N1, 1);
% 
% for i = 1: N1
%     
% iter = 0;
% while abs(k_old(i)-k(i)) > 10^-3 && k(i) ~= 0
%     k_old(i) = 0.5*k(i);
%     k(i) = k_old(i) - (g*k_old(i)*tanh(k_old(i)*h(i))-af^2)/(g*tanh(k_old(i)*h(i))+g*h(i)*k_old(i)*(sech(k_old(i)*h(i)))^2);
%     iter = iter + 1;
% end
% 
% end
% k
k = zeros(N1,1);
iter=20;k(1)=1;
for i=1:N1
    for j=2:iter
        k(i+1)=k(i)-(g*k(i)*tanh(k(i)*h(i))-af^2)/(g*tanh(k(i)*h(i))+g*h(i)*k(i)*(sech(k(i)*h(i)))^2);
    end
end
kl=k
break
%%%%%%%%%
% sams
%%%%%%%%% TEST
% f1 = @(k)g*k*tanh(k*h)-af^2;
% ff1 = @(k)g*tanh(k*h)+g*h*k*(sech(k*h)).^2;
% 
% iter = 20;
% k = zeros(N1,1);
% for j = 1:iter
%     dk = f1/ff1;
%     k  = k-dk;
% end
% k

%%%%%%%%%
% monty
%%%%%%%%%
% tol=10^(-3);
% j=1;k(j)=0;k1=k(j);
% k(j+1)=k(j)-f1(k1)/ff1(k1)
% break
% 
% while abs(k(j)-k(j+1))<tol
%     k1=k(j);
%     
% k(j+1)=k(j)-f1(k1)/ff1(k1);
% 
% end
% kk=k