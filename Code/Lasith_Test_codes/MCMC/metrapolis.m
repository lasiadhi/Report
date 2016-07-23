% MCMC - to recover one parameter
clc
clear

% generate synthatic Gaussian noisy data
L    = 1;
dx   = 0.01;
xvec = [0:dx:L]';

truealpha  = 2;
truesigma0 = 1;

true_sol = ODE_sol(truealpha, xvec);
noisy_data = true_sol + truesigma0 * randn(length(xvec), 1);


% algorithm parameters
burnin   = 1000;   % markov chain need to converge 
numsteps = 10000;
totsteps = numsteps + burnin;

x0(1) = 0.5;  % initial guess for the alpha

oldpost = likelihood(noisy_data, x0(1), truesigma0, xvec)  + myprior(x0(1));


for i = 1 : (totsteps-1)

    % generate proposal
    z = 0.5^2 * randn(1);    % change SD 0.5 here
    prop = x0(i) + z;
    
    % calculate posterior density
    proppost = likelihood(noisy_data, prop, truesigma0, xvec) +  myprior(prop);
    rho = exp(proppost - oldpost);
    
    % accept/reject step
    u = rand;
    if rho > u
        x0(i+1) = prop;
        oldpost = proppost;
    else
        x0(i+1) = x0(i);
    end   
     
    
end


% throw away the burnin steps
    x = x0((burnin+1):totsteps);
    
    % keep every 10th step
    x = x(1:10:length(x));
    
    [f,x]=ksdensity(x);
    plot(x,f);
    [M I] = max(f)


