% Compute the Tikhonov regularized solution with a prior infomation

clc
clear

% load A, b here
% Let's use simulated data
N  = 50;
A  = randn(N);   % forward operator

x = linspace(-11,0,N)';
ht = -x - 11;  % true depth 

sigma = 0.2;                           % variance
b     = A * ht + sigma * randn(N,1);   % noisy measurements

h0  = ht + sigma * randn(N,1); 


[U,s,V] = svd(A);
[h_lambda,rho,eta] = tikhonov(U,diag(s),V,b,1e-1,h0);
stem(ht,'b');
hold on
stem(h_lambda,'r');
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
title('Tikhonov regularized solution with a prior infomation', 'FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry'},'FontSize',14);

solution_norm = eta
residual_norm = rho

