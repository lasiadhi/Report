% subfucntion for k (wave number)
%
% use 'fsolve' for non-linear equation
%
% call by bathymetry

% original version by dwb

function[k] = wavenumber(xmax, Tb, h)

%% Constants
g = 9.8;        % unit (m/s2)

%% INPUT
% Tb: wave period at boundary 
% h: vector of depth (dimension as grid point, unit as meter)

%% Dispersion equation
% af^2 = g*k*tanh(k*h)

%% Number of grid point
N1 = length(h);


%% xmax(the maximum length in x-direction)

%% af: angular fruquency
af = 2*pi/Tb;

%% Initialize k vector
k = zeros(N1, 1);
kk = 0;

for i = 1: N1
      k0 = 1;
      hh = h(i);
      fct = @(kk)af^2 - g*kk*tanh(kk*hh);
      kk = fsolve(fct, k0);
    k(i) = kk;
end

% Number of grid
N = N1-1;

% Mesh size
xmin = 0;
  dx = (xmax - xmin)/N; 

% x vector for plot
x    = zeros(N1, 1);
x(1) = xmin;
for i = 2: N1
    x(i) = x(1) + (i-1)*dx;
end
    
    