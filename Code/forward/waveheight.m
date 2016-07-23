% USACE-Bathymetry
%
% Forward problem
%
% this is a subfunction to get wave height

% original version by dwb

function[H, n, cc, c_g, x] = waveheight(xmax, Hmax, h, Tb, k, delta, dx)

%% INPUT:
% xmax(the maximum length in x-direction)
% hmax(the maximum depth in x-direction)
% Tb(wave period at boundary)
% Hb(wave height at boundary)
% Tb(wave period at boundary)
% rho(water density)
% g(gravity accleration)
% h(bathymetry info, depth)
% delta

%% OUTPUT:
% H(wave height)
% x(vector to plot)

%% constants
g = 9.8;        % m/s2
rho = 1000;     % kg/m3

% Number of grid point
N1 = length(h);

% Number of grid
%N = N1-1;

% Boundary Condition
H = zeros(N1, 1);
H(1) = Hmax;

% mesh size                 %%%% not using anymore, just for test
%xmin = 0;
%dx = (xmax - xmin)/N;

% x vector for plot
%x = xmin: dx: xmax;

% Constant
lambda = rho*g*pi/(8*Tb);

% Coefficient
cc  = zeros(N1, 1);
n   = zeros(N1, 1);
c_g = zeros(N1, 1);
for i = 1: N1
    n(i)    = (1+(2*k(i)*h(i))/sinh(2*k(i)*h(i)))/2;
    c_g(i)  = 2*pi*n(i)/Tb;
    cc(i)    = c_g(i)*lambda/k(i);
end

% Coefficient
c = zeros(N1, 1);

for i = 1: N1
    c(i) = (1+(2*k(i)*h(i))/sinh(2*k(i)*h(i)))*lambda/k(i);
end

% Wave Height Limit (H<Hmax)
H1    = zeros(N1, 1);
H1(1) = H(1);
for i = 2: N1
    H1(i) = (delta(i)*dx + c(i-1)*(H1(i-1))^2)/c(i);
    H1(i) = sqrt(H1(i));
    Hmax  = 0.78*h(i);
    H(i)  = min(H1(i),Hmax);
end
