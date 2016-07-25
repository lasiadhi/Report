

function p2 = myprior(x)

% known values
mu    = 0;
sigma = 1;

%% bounded h
x(x<0) = 1e+7;
x(x>11) = 1e+7;
%%

% Gaussian prior
p2 = sum(log(normpdf(x,mu,sigma)));

end