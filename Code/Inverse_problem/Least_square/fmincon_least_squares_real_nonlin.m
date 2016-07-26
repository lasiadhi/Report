clc
clear 
close all

load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');
dx	= x_data(2) - x_data(1);
N  	= size(x_data,1);

[h,x] 		= get_hOct9;
[hgrid,xq] 	= interp_h(h,x,dx);
h_guess    	= initialize_h_guess_pointwise(hgrid, xq, dx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('Display','off');
options = optimset('Display','iter', 'MaxFunEvals', 15000, 'TolFun', 1e-5);

h_hat3    = fmincon(@objective_2norm_real_nonlin, h_guess, [],[],[],[], zeros(N,1), repmat(11,[N,1]),[], options);

% Remove points where there are no measurements for K and replace
% Linear interpolation
% We know h = 0 at h(1)
num = 2;
h_approx_subset(1) = 0;
x_subset(1) = 1150;

for i = 2:length(h_guess)
	if ~isnan(k_data(i))
		h_approx_subset(num) = h_hat3(i);
		x_subset(num) = xq(i);
		num = num + 1;
	else
	end
end
h_approx_subset(num) = 11;
x_subset(num) = 0;

h_approx = interp1(x_subset,h_approx_subset,xq,'linear');

figure(3)
subplot(2,1,1)
plot(xq,hgrid, '-b');
hold on
plot(xq,h_approx, '-^r');
% plot(xq,h_hat3, '-r');
title('fmincon Method with Real Data', 'fontSize',14);
xlim([0,1150])
xlabel('x Position (m)','FontSize',14);
ylabel('Depth (m)','FontSize',14);
set(gca,'ydir','reverse')
set(gca,'xdir','reverse')
hold on
plot(xq,h_guess,'g')
legend({'True h','Processed Recovered h','Initial guess'},'FontSize',14);

subplot(2,1,2)
scatter(x_data,k_data,'*k')
legend({'Wave Number Measurements'},'FontSize',14);
xlabel('x Position (m)','FontSize',14);
ylabel('Wave Number');
set(gca,'xdir','reverse');
xlim([0,1150])

