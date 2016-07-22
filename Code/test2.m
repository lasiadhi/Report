g = 9.8;        % m/s2
rho = 1000;     % kg/m3
h = [0; 0.3; 0.8; 1.4; 2.0; 2.6; 3.2; 4.0; 4.8; 2.6; 3.0; 3.6; 4.5; 5.5; 6.5; 7.5; 8.5; 9.5; 10; 11];

Hmax = 2;
xmax = 2;
% to get the value of number of subinterval
[N1, N2] = size(h);

% N number of subinterval
N = N1-1;

% Boundary Condition
H = zeros(N1, 1);
H(1) = 0;
H(N1) = Hmax;

% mesh size
xmin = 0;
dx = (xmax - xmin)/N;


% af: angular fruquency
Tb = 1;
af = 2*pi/Tb;
%break
% Initial vector of wave number
k = zeros(N1, 1);

% get k
k0 = 0;         %%%%%%%%%%% need to change %%%%%%%%%%
f1 = @(k)g*k*tanh(k*h)-af^2;
%break
for i = 1: N1
    kk = k0;
    %hh = h(i);
    %k(i) = fsolve(g*k(i)*tanh(k(i)*hh)-af^2, kk);
    k(i) = fsolve(f1,kk);
    k0 = k(i);
end
k1 = k
 