% MCMC - to recover one parameter
clc
clear

%Get k data and variance
addpath('../../../Data/')
kdat=get1Dk();
[~,k1Dstd]=get1DkStats();
kdat_std = mean(k1Dstd_dat);
vark = kdat_std^2;

%Data for prior
bath=load('../../../Data/transect_depth_ensembles_500_dx_10.mat');
%x = [0:10:1140]'; %bath.x doesn't have the correct dims, so fixing that

% Metropolis things
burnin   = 1000;   % markov chain need to converge 
numsteps = 10000;
totsteps = numsteps + burnin;

% Initial vector for quantity of interest we're estimating
h = zeros(length(bath.depth),totsteps);

% Initial guess for h (from previous data)
% For the moment this is the true bathymetry
% will eventually be like proposal
[h(:,1),~] = get_hOct1();

%Initial guess for forward model
[kFor, ~] = forward(h(:,1));

%Initial posterior
[ lprior, depthmean_prior, depthstd_prior] = logprior(h(:,1),bath);
llikelihood = loglikelihood(kdat, kFor, vark);
oldpost =  llikelihood + lprior;

%Metropolis loop
for i = 1 : (totsteps-1)

    % Propose h
    hprop = normrnd(depthmean_prior,depthstd_prior);
    %Get proposed k | h
    [kprop, ~] = forward(hprop);

    % calculate posterior density
    proppost = loglikelihood(kdat, kprop, vark) +  logprior(hprop);
    rho = exp(proppost - oldpost);
    
    % accept/reject step
    u = rand;
    if rho > u
        h(i+1) = prop;
        oldpost = proppost;
    else
        h(i+1) = h(i);
    end   

end

% throw away the burnin steps
    h_final = h((burnin+1):totsteps);
    
    % keep every 10th step
    h_final = h_final(1:10:length(f_final));
    



%     [f,x]=ksdensity(x);
%     plot(x,f);
%     [M I] = max(f)


