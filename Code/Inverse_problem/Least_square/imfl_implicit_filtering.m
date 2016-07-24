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
%options = imfil_optset('least_squares', 1);
%options = imfil_optset('Display', 'iter');
%[h_hat4,ifail,icount]  = imfil(h_guess, @obj_f, 5000, [zeros(N,1), repmat(15,[N,1])], options)
[h_hat4,ifail,icount]  = imfil(h_guess, @obj_f_imfil, 5000, [zeros(N,1), repmat(15,[N,1])])

figure(3)
plot(xq,hgrid, '-*b');
hold on
plot(xq,h_hat4, '-^r');
title('Implicit Filtering Method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
set(gca,'ydir','reverse')
set(gca,'xdir','reverse')
hold on
plot(xq,h_guess,'g')
legend({'True h', 'Recovered h','Initial guess'},'FontSize',14);

