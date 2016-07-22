% subfucntion for k (wave number)
%
% use 'fsolve' for non-linear equation
%
% call by bathymetry

% original version by dwb

function[k] = wavenumber(Tb, h)

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

for i = 1: N1
    if h(i) ~= 0
        k0 = af/(sqrt(h(i)*g));
        hh = abs(h(i));
       fct = @(kk) (g*kk*tanh(kk*hh)-af^2);
        kk = fsolve(fct, k0);
      k(i) = kk;
    else
        k(i) = 0;
    end
end
    