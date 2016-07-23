

function p2 = myprior(x)

% known values
mu    = 0;
sigma = 1;

% Gaussian prior
p2 = log(normpdf(x,mu,sigma));

end