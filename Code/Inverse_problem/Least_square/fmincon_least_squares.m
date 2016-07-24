clc
clear 
close all

N     = 47; %116;  %47
dx    = 25; %10;  %25
[h,x] = get_hOct1;
[hgrid,xq] = interp_h(h,x,dx);
%h_guess = initialize_h_guess(hgrid,dx);
h_guess    = initialize_h_guess_pointwise(hgrid, xq, dx);


load('k_1percNoisedata_N47.mat','k'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('Display','off');
options = optimset('Display','iter');
%[h_hat2,exitflag,output] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options)
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)', [],[],[],[], zeros(N,1), repmat(12,[N,1]),[], options);
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)', [],[],[],[], -inf(N,1), inf(N,1),[], options);
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)',[],[],[],[],[],[],[],options);
%h_hat3   = fmincon(@objective_2norm, hgrid,[],[],[],[],[],[],[],options);
h_hat3    = fmincon(@objective_2norm, h_guess, [],[],[],[], zeros(N,1), repmat(20,[N,1]),[], options);
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

