clc
clear 
close all

load('Real_data_2015-10-09_21:59:00_10m.mat','x_data');
dx	= x_data(2) - x_data(1);
N  	= size(x_data,1);

[h,x] 		= get_hOct9;
[hgrid,xq] 	= interp_h(h,x,dx);
%h_guess = initialize_h_guess(hgrid,dx);
%h_guess    = initialize_h_guess_pointwise_16(hgrid, xq, dx);
h_guess    	= initialize_h_guess_pointwise(hgrid, xq, dx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('Display','off');
options = optimset('Display','iter');
%[h_hat2,exitflag,output] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options)
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)', [],[],[],[], zeros(N,1), repmat(12,[N,1]),[], options);
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)', [],[],[],[], -inf(N,1), inf(N,1),[], options);
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)',[],[],[],[],[],[],[],options);
%h_hat3   = fmincon(@objective_2norm, hgrid,[],[],[],[],[],[],[],options);
h_hat3    = fmincon(@objective_2norm_real, h_guess, [],[],[],[], zeros(N,1), repmat(11,[N,1]),[], options);
%h_hat3   = fmincon(@objective_2norm, h_guess, [],[],[],[], zeros(N,1), repmat(12,[N,1]),[], options);

figure(3)
plot(xq,hgrid, '-*b');
hold on
plot(xq,h_hat3, '-^r');
title('fmincon method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
set(gca,'ydir','reverse')
set(gca,'xdir','reverse')
hold on
plot(xq,h_guess,'g')
legend({'True h', 'Recovered h','Initial guess'},'FontSize',14);

