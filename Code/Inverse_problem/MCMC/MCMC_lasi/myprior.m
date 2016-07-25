

function p2 = myprior(x)

% known values
mu    = 0;
sigma = 0.5;

%% bounded h
x(x<0) = 1e+10;
x(x>11) = 1e+10;
%%

% Gaussian prior
p2 = sum(log(normpdf(x,mu,sigma)));

end