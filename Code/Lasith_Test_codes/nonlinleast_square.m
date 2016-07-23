% Matlab's lsqnonlin and lsqnonneg to solve nonlinear function

clc
clear
close all

%load A, b here
%Let's use simulated data
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

% h1 = rand(10,1);  
% f(h1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonneg: Solve nonnegative least-squares constraint problem
options = optimset('Display', 'final');
[h_hat1,resnorm1] = lsqnonneg(A, b,options);
resnorm1

figure(1)
stem(-ht, 'b');
hold on
stem(-h_hat1, 'r');
title('Nonnegative least-squares method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry'},'FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonlin: trust-region-reflective method
options = optimoptions('lsqnonlin','Display','iter');
%options = optimset('Display', 'iter');
%[h_hat2,exitflag,output] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options)
%[h_hat2,resnorm2] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options);
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('lsqnonlin','Display','iter');
%options = optimset('MaxFunEvals', 5000);
%[h_hat2,exitflag,output] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options)
h_hat3   = fmincon(f_norm, zeros(N,1), [],[],[],[], zeros(N,1), inf(N,1));
resnorm3 = norm(ht - h_hat3)

figure(3)
stem(-ht, 'b');
hold on
stem(-h_hat3, 'r');
title('fmincon method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry'},'FontSize',14);








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%levenberg-marquardt method
options = optimoptions('lsqnonlin','Display','iter', 'Algorithm', 'levenberg-marquardt');
[h_hat5,resnorm5] = lsqnonlin(f, zeros(N,1), -inf(N,1),inf(N,1), options);
resnorm5


figure(5)
stem(-ht, 'b');
hold on
stem(-h_hat5, 'r');
title('Levenberg-Marquardt method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry'},'FontSize',14);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%imfil: implicit filtering method
options = imfil_optset('least_squares', 1);
[h_hat4,ifail,icount]  = imfil(repmat(1,[N,1]), @obj_f, 5000, [zeros(N,1), repmat(4,[N,1])], options)
%[h_hat4,ifail,icount] = imfil(repmat(0,[N,1]), @obj_f, 5, [zeros(N,1), inf(N,1)], options)

figure(4)
stem(-ht, 'b');
hold on
stem(-h_hat4, 'r');
title('Implicit filtering method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True Bathymetry', 'Recovered Bathymetry'},'FontSize',14);

% simple example
% options = imfil_optset('least_squares', 1);
% x = imfil([0.5; 0.5], @f_easy, 40, [-1, 1; -1 1], options)
