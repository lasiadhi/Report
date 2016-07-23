%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lsqnonlin: trust-region-reflective method
clc
N = 116;
dx = 10;
[h,x] = get_hOct1;
[hgrid,xq] = interp_h(h,x,dx);
%h_guess = initialize_h_guess(hgrid,dx);
%h_guess = h_guess';

int_h = hgrid + 0.1 * randn(N,1);


load('k_2_5percNoisedata.mat','k'); 

options = optimoptions('lsqnonlin','Display','iter');
[h_hat,resnorm2] = lsqnonlin(@objective, int_h, zeros(N,1),repmat(11,[N,1]),options);
resnorm2;
%resnorm2_1 = norm(ht - h_hat2)

figure(2)
stem(hgrid, 'b');
hold on
stem(h_hat, 'r');
title('Trust-region-reflective method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('depth (h)','FontSize',14);
legend({'True h', 'Recovered h'},'FontSize',14);