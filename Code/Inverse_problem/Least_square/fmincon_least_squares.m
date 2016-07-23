clc
clear 

N = 116;

load('k_2_5percNoisedata.mat','k'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('Display','off');
options = optimset('Display','off');
%[h_hat2,exitflag,output] = lsqnonlin(f, zeros(N,1), zeros(N,1),inf(N,1),options)
h_hat3   = fmincon(@objective_2norm, ones(N,1), [],[],[],[], zeros(N,1), repmat(11,[N,1]),[], options);


figure(3)
stem(k, 'b');
hold on
stem(h_hat3, 'r');
title('fmincon method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True k', 'Recovered k'},'FontSize',14);

