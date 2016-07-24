% obj_f

function [fv,ifail,icount] = obj_f_imfil(h)

load('k_1percNoisedata_N47.mat','k_noisy');   % load k_noisy data

[k_appro, H] = forward(h);
fv =  norm(k_appro - k_noisy)^2 +  1e-4 * norm(h)^2;

%
% This function never fails to return a value
%
ifail = 0;
%
% and every call to the function has the same cost.
%
icount=1;