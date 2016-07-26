%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonlin: trust-region-reflective method for synthetic data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
N = 116;
dx = 10;
[h,x] = get_hOct1;
[hgrid,xq] = interp_h(h,x,dx);
%h_guess = initialize_h_guess(hgrid,dx);
h_guess = initialize_h_guess_pointwise(hgrid, xq, dx);

load('k_2_5percNoisedata.mat','k_noisy');   % load k_noisy data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimoptions('lsqnonlin','Display','iter');
[h_hat,resnorm2] = lsqnonlin(@objective, h_guess+1e-5, zeros(N,1),repmat(12,[N,1]),options);
resnorm2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plots for nonlinear least square results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
plot(xq,hgrid, '-*b');
hold on
plot(xq,h_hat, '-r');
hold on
plot(xq,h_guess+1e-4,'-og');
title('Least Square Method (lsqnonlin) for Synthetic Data', 'fontSize',14)
set(gca,'ydir','reverse')
set(gca,'xdir','reverse')
xlabel('x Position (m)','FontSize',14);
ylabel('depth (m)','FontSize',14);
legend({'True Bathymetry (h_t)', 'Recovered Bathymetry','Initial guess'},'FontSize',14);