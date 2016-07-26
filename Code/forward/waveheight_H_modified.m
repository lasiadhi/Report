% USACE-Bathymetry
%
% Forward problem
%
% this is a subfunction to get wave height

% original version by dwb

function[H, n, cc1, c_g, E, delta] = waveheight_H_modified(Hmax, hgrid, Tb, k, dx)

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
N1 = length(hgrid);

% Number of grid
%N = N1-1;

% Boundary Condition
    H = zeros(N1, 1);
    E = zeros(N1, 1);
%   cc = zeros(N1, 1);                     %%%%%%%% celerity
  cc1 = zeros(N1, 1);                     %%%%%%%% celerity
    n = zeros(N1, 1);
  c_g = zeros(N1, 1);                     %%%%%%%% group celerity
delta = zeros(N1, 1);
H_rms = zeros(N1, 1);
  H_b = zeros(N1, 1);
    R = zeros(N1, 1);

H(1) = Hmax;
H_rms(1) = Hmax*0.707;
% change calculation to E for simplicity tjh
E(1) = 1.0/8.0*rho*g*(H_rms(1))^2.0;

% mesh size                 %%%% not using anymore, just for test
%xmin = 0;
%dx = (xmax - xmin)/N;

% x vector for plot
%x = xmin: dx: xmax;

% Constant
% lambda = rho*g*pi/(8*Tb);

% Coefficient
for i = 1: N1
    n(i)  = (1+(2*k(i)*hgrid(i))/sinh(2*k(i)*hgrid(i)))/2;
    cc1(i) = 2*pi/(Tb*k(i));
    %cc(i) = sqrt(g*h(i));       %%%%% shallow water approx
    % calculate c_g using dispersion and not shallow water theory tjh
    c_g(i)= cc1(i)*n(i);
end
% % Coefficient
% coe = zeros(N1, 1);
% 
% for i = 1: N1
%     coe(i) = (1+(2*k(i)*h(i))/sinh(2*k(i)*h(i)))*lambda/k(i);     %%%%% coefficient
% end

% Wave Height Limit (H<Hmax)
for i = 2: N1-10
%     if abs(h(i))<=10^(-3)
%         H(i) = 0;
%     else
      beta = 1;
         f = 1/Tb;
H_rms(i-1) = 0.707*H(i-1);  % I am sorry this is messed up.  H_rms = 2sqrt(2)*mo H = 4sqrt(mo)  tjh
  H_b(i-1) = 0.78*hgrid(i-1);        % This 0.78 is from breaking condition
    R(i-1) = H_b(i-1)/H_rms(i-1);
    
delta(i-1) = -1/(4*hgrid(i-1))*beta*rho*g*f*H_rms(i-1)^3*((R(i-1)^3+(3/2)*R(i-1))*exp(-R(i-1)^2)+(3/4)*sqrt(pi)*(1-erf(R(i-1))));  % negative for dissipation
      % calculate next spatial step using E and not H for simplicity tjh
      E(i) = delta(i-1)*dx/c_g(i) + E(i-1)*c_g(i-1)/c_g(i);
  H_rms(i) = sqrt(8.0*E(i)/(rho*g));
      H(i) = H_rms(i)/0.707;
      %H(i) = (delta(i-1)*dx + coe(i-1)*(H(i-1))^2)/coe(i);
      %H(i) = sqrt(H(i));
end
    
%     Hmax  = 0.78*h(i);
%     if H1(i)<=Hmax
%         m(i) = 1;
%     else
%         m(i) = 2;
%     end
%     H(i)  = min(H1(i),Hmax);
end
%H = H/0.707;
%H_rms
%H_b
%R