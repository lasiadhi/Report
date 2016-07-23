% MCMC - to recover one parameter
clc
clear

%Get k data
k1D=get1Dk();


% Metropolis things
burnin   = 1000;   % markov chain need to converge 
numsteps = 10000;
totsteps = numsteps + burnin;

%Initial guess for h (from previous data)
%x0(1) = 0.5;  % initial guess for the alpha

%Initial posterior
oldpost = loglikelihood(k1D, kFor, sigk)  + logprior(x0(1));

%Metropolis loop
for i = 1 : (totsteps-1)

    %Get modeled k
    [kFor, H] = forward(hgrid);

    % generate proposal
    z = 0.5^2 * randn(1);    % change SD 0.5 here
    prop = x0(i) + z;
    
    % calculate posterior density
    proppost = loglikelihood(noisy_data, prop, truesigma0, xvec) +  logprior(prop);
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


