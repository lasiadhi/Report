% MCMC - to recover one parameter

clc
clear 
close all
tic

load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');
dx	= x_data(2) - x_data(1);
N  	= size(x_data,1);

[h,x] 		= get_hOct9;
[hgrid,xq] 	= interp_h(h,x,dx);


% N     = 47; %116;  %47
% dx    = 25; %10;  %25
% [h,x] = get_hOct9;
% [hgrid,xq] = interp_h(h,x,dx);
%h_guess = initialize_h_guess(hgrid,dx);
%h_guess    = initialize_h_guess_pointwise_16(hgrid, xq, dx);
h_guess    = initialize_h_guess_pointwise(hgrid, xq, dx);


%load('k_1percNoisedata_N47.mat','k_noisy'); 
%k_sd = 1e-3;

k_sd = 9e-2;

% generate synthatic Gaussian noisy data
% L    = 1;
% dx   = 0.01;
% xvec = [0:dx:L]';
% 
% truealpha  = 2;
% truesigma0 = 1;
% 
% true_sol = ODE_sol(truealpha, xvec);
% noisy_data = true_sol + truesigma0 * randn(length(xvec), 1);


% algorithm parameters
burnin   = 500;   % markov chain need to converge 
numsteps = 1000;
totsteps = numsteps + burnin;

x0(:,1) = h_guess;  % initial guess for the alpha

oldpost = likelihood(k_data, x0(:,1), k_sd)  + myprior(x0(:,1));


for i = 1 : (totsteps-1)
    i
    % generate proposal
    z = 0.5 * randn(N,1);    % change SD 0.5 here
    prop = x0(:,i) + z;
    
    % calculate posterior density
    proppost = likelihood(k_data, prop, k_sd) +  myprior(prop);
    rho = exp(proppost - oldpost);
    
    % accept/reject step
    u = rand;
    
    
        if rho > u
            x0(:,i+1) = prop;
            oldpost = proppost;
        else
            x0(:,i+1) = x0(:,i);
        end
    
     
    
end



% throw away the burnin steps
    x_final = x0(:,(burnin+1):totsteps);
    
%keep every 10th step
    [r c]   = size(x_final);
    x_final = x_final(:,1:10:c);

    
    h_final = zeros(N,1);
    for j = 1:N
        xj = x_final(j,:);
        xj_chooped = xj(xj >= 0 & xj <= 11);
        [f,xx] = ksdensity(xj_chooped);
        %plot(x,f);
        [M I] = max(f);
        h_final(j) = xx(I);
    end
    
    toc

figure(1)
plot(xq,hgrid, '-*b');
hold on
plot(xq,h_final, '-^r');
t=title('MCMC - Metropolis Hastings Algorithm', 'fontSize',14);
x=xlabel('x Position (m)','FontSize',14);
y=ylabel('Depth (m)','FontSize',14);
set(gca,'ydir','reverse')
set(gca,'xdir','reverse')
hold on
plot(xq,h_guess,'g')
l=legend({'True h', 'Recovered h','Initial guess'},'FontSize',14);
set(x,'Interpreter','Latex');
set(y,'Interpreter','Latex');
set(t,'Interpreter','Latex');
set(l,'Interpreter','Latex');


