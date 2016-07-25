%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonlin: trust-region-reflective method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
N = 116;
dx = 10;
[h,x] = get_hOct9;
[hgrid,xq] = interp_h(h,x,dx);
%h_guess = initialize_h_guess(hgrid,dx);
h_guess = initialize_h_guess_pointwise(hgrid, xq, dx);

load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');   % load real k_data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimoptions('lsqnonlin','Display','iter');
[h_hat,resnorm2] = lsqnonlin(@objective_real, h_guess+1e-5, zeros(N,1),repmat(12,[N,1]),options);
resnorm2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plots for nonlinear least square results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
plot(xq,hgrid, '-*b');
hold on
plot(xq,h_hat, '-r');
hold on
plot(xq,h_guess+1e-5,'-og');
title('lsqnonlin:trust-region-reflective method', 'fontSize',14)
set(gca,'ydir','reverse')
set(gca,'xdir','reverse')
xlabel('Distance from the coastline','FontSize',14);
ylabel('depth (h) m','FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry','Initial guess'},'FontSize',14);