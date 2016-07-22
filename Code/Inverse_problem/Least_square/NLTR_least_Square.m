%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonlin: trust-region-reflective method
clc
N = 116;

load('k_2_5percNoisedata.mat','k'); 

options = optimoptions('lsqnonlin','Display','iter');
[k_hat,resnorm2] = lsqnonlin(@objective, zeros(N,1), zeros(N,1),inf(N,1),options);
resnorm2
%resnorm2_1 = norm(ht - h_hat2)

figure(2)
stem(k, 'b');
hold on
stem(k_hat, 'r');
title('Trust-region-reflective method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry'},'FontSize',14);