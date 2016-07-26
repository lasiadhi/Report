clc
clear 
close all

load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');
dx	= x_data(2) - x_data(1);
N  	= size(x_data,1);

[h,x] 		= get_hOct9;
[hgrid,xq] 	= interp_h(h,x,dx);

[k_true, ~] = forward_real(hgrid,dx);

notnanlocations = ~isnan(k_data);
k_sub = k_data(notnanlocations);  % noisy data without NANs
k_true_sub = k_true(notnanlocations);  % corresponding k true values

%format long e
Gaussian_noise = norm(k_true_sub - k_sub)/norm(k_sub) * 100

plot(flip(k_sub),'b')
hold on
plot(flip(k_true_sub),'r')



