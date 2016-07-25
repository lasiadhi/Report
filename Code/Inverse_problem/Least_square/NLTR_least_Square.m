%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonlin: trust-region-reflective method
clc
N = 116;
dx = 10;
[h,x] = get_hOct9;
[hgrid,xq] = interp_h(h,x,dx);
%h_guess = initialize_h_guess(hgrid,dx);
h_guess = initialize_h_guess_pointwise(hgrid, xq, dx);
%h_guess = h_guess';

%int_h = hgrid + 0.1 * randn(N,1);


load('k_2_5percNoisedata.mat','k'); 

options = optimoptions('lsqnonlin','Display','iter');
[h_hat,resnorm2] = lsqnonlin(@objective, h_guess+1e-5, zeros(N,1),repmat(12,[N,1]),options);
resnorm2;
%resnorm2_1 = norm(ht - h_hat2)

figure(2)
plot(xq,hgrid, '-*b');
hold on
plot(xq,h_hat, '-r');
hold on
plot(xq,h_guess+1e-5,'-og');
title('lsqnonlin:trust-region-reflective method', 'fontSize',14)
set(gca,'ydir','reverse')
set(gca,'xdir','reverse')
xlabel('Distance from the coastline','FontSize',14);
ylabel('depth (h) m','FontSize',14);
legend({'True h', 'Recovered h','Initial guess'},'FontSize',14);