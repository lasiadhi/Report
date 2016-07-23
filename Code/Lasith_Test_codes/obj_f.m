% obj_f

function [fv,ifail,icount] = obj_f(x)
% our objective function
% Simple example of using imfil.m
%
% fv=x'*x;
% fv=fv*(1 + .1*sin(10 * (x(1) + x(2) ) ));

% N  = length(x);
% A  = randn(N);   % forward operator
% 
% ht = rand(N,1);  % true depth 
% 
% sigma = 0.01;                          % variance
% b     = A * ht + sigma * randn(N,1);   % noisy measurements
load('sample_dataset_N50.mat') % load A and b
fv = norm(A * x - b)^2;


%
% This function never fails to return a value
%
ifail = 0;
%
% and every call to the function has the same cost.
%
icount=1;