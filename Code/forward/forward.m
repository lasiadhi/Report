function [k, H] = forward(hgrid)

xmax = 1150;
dx = 25; %10;
%% CALL-1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get Boundary Conditions (vector for a fixed time period, record hourly)
% These BCs are for October 1st test with synthetic data.
%Hmax_vec = getBC('waveHs', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
%  Tb_vec = getBC('wavePeakFrequency', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
  
% Choose one set of Hmax_vec & Tb_max (index must match)
%Hmax = Hmax_vec(1);
%  Tb = (Tb_vec(1))^(-1);

Tb = 10.00;

%% CALL-4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get wave number
k = wavenumber(Tb, hgrid);

%% CALL-5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get delta (rhs of the ODE)
%delta = rhs_delta(hgrid, Tb, Hmax);


%% CALL-6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get wave height from energy flux eqn by FDM
%[H] = waveheight(Hmax, hgrid, Tb, k, delta, dx);
H = 0;


end