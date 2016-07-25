function [k, H] = forward_real_nonlin(hgrid,dx)

xmax = 1150;

%% Get Boundary Conditions (vector for a fixed time period, record hourly)
% ------------BCs for October 1st test with synthetic data. ---------------
%  Hmax_vec = getBC('waveHs', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
%  Tb_vec = getBC('wavePeakFrequency', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
  
% Choose one set of Hmax_vec & Tb_max (index must match)
%  Hmax = Hmax_vec(1);
%  Tb = (Tb_vec(1))^(-1);

%  Tb = 10.00; Hard coded BC (taken from actual BC data)

%-------------BCs for October 9th test with real data --------------------
% Time of BC measurements: 2015-10-09 22:00:08
% Time of k measurements: 2015-10-09 21:59:00

% Hmax_vec = getBC('waveHs','2015-10-09 20:00:00','2015-10-10 01:00:00');
% Tb_vec = getBC('wavePeakFrequency','2015-10-09 20:00:00','2015-10-10 01:00:00');

% Take the first index
% Hmax = Hmax_vec(1);
% Tb = (Tb_vec(1))^(-1);

% Hard coded versions to avoid cost of calling data from server.
Hmax = 0.6663;
Tb = 11.7647;

%% Get linear wave number
k_lin = wavenumber(Tb, hgrid);

%% Get delta (rhs of the ODE)
delta = rhs_delta(hgrid, Tb, Hmax);

%% Get wave height from energy flux eqn by FDM
H = waveheight(Hmax, hgrid, Tb, k_lin, delta, dx);

%% Get non linear wave number
k = nonlin_wavenumber(Tb, hgrid, H, k_lin);

end