clc
clear 

N = 47; %116;  %47
dx = 25; %10;  %25
[h,x] = get_hOct1;
[hgrid,xq] = interp_h(h,x,dx);
h_guess = initialize_h_guess(hgrid,dx);

load('k_1percNoisedata_N47.mat','k'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('Display','off');
options = optimset('Display','iter', 'TolFun',1e-3, 'TolCon', 1e-3);
%[h_hat2,exitflag,output] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options)
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)', [],[],[],[], zeros(N,1), repmat(12,[N,1]),[], options);
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)', [],[],[],[], -inf(N,1), inf(N,1),[], options);
%h_hat3   = fmincon(@objective_2norm, abs(h_guess)',[],[],[],[],[],[],[],options);
%h_hat3   = fmincon(@objective_2norm, hgrid,[],[],[],[],[],[],[],options);
h_hat3   = fmincon(@objective_2norm, hgrid + 0.1*randn(N,1), [],[],[],[], zeros(N,1), repmat(12,[N,1]),[], options);
%h_hat3   = fmincon(@objective_2norm, h_guess, [],[],[],[], zeros(N,1), repmat(12,[N,1]),[], options);

figure(3)
stem(hgrid, 'b');
hold on
stem(h_hat3, 'r');
title('fmincon method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True h', 'Recovered h'},'FontSize',14);

