% Matlab's lsqnonlin to solve nonlinear function
% Using the data from the model and 
clc
clear
close all
% load A, b here
% Let's use simulated data
% N  = 50;
% A  = rand(N);   % forward operator
% 
% ht = rand(N,1);  % true depth 
% ht = linspace(0,11,N)';
% 
% 
% sigma = 0.1;                          % variance
% b     = A * ht + sigma * randn(N,1);   % noisy measurements

load('sample_data_linearSlopeN50.mat')


% user-defined function
f = @(h) A * h - b;
f_norm = @(h) norm(A * h - b);  % A not necessaraly be a matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonlin: trust-region-reflective method
options = optimoptions('lsqnonlin','Display','iter');
[h_hat2,resnorm2] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options);
resnorm2
%resnorm2_1 = norm(ht - h_hat2)

figure(2)
stem(-ht, 'b');
hold on
stem(-h_hat2, 'r');
title('Trust-region-reflective method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry'},'FontSize',14);