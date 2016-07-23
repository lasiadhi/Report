clc
clear 

% N = 116; 
% dx = 10; 

N = 47; 
dx = 25; 

[h,x] = get_hOct1;
[hgrid,xq] = interp_h(h,x,dx);
h_guess = initialize_h_guess_pointwise(hgrid, xq, dx);

% load('k_2_5percNoisedata.mat','k'); 
 load('k_1percNoisedata_N47.mat','k'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('Display','off');
<<<<<<< HEAD
options  = optimset('Display', 'iter', 'TolFun', 1e-5, 'MaxIter', 30);          %,'MaxIter',10   %,'TolFun',1e-3
h_hat3   = fminsearch(@objective_2norm, h_guess, options);              %, [], [], [], [], zeros(N,1), repmat(12, [N,1]), []
=======

options  = optimset('Display','iter','TolFun',1e-3,'MaxIter',5000);
h_hat3   = fminsearch(@objective_2norm, h_guess, options);

>>>>>>> c312997143f70b537121981fa67497342e730e09


figure(3)
stem(hgrid, '*b');
hold on
<<<<<<< HEAD
stem(h_hat3, '^r');
hold on
stem(h_guess, '<')
title('fmincon method', 'fontSize',14)
=======
stem(h_hat3, 'r');
title('fminsearch method', 'fontSize',14)
>>>>>>> c312997143f70b537121981fa67497342e730e09
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True h', 'Recovered h', 'initial guess h'},'FontSize',14);

