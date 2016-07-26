

function p2 = myprior(x)

% known values
mu    = 0;
sigma = 3;

%% bounded h
% x(x<0) = 1e+10;
% x(x>11) = 1e+10;
%%

n = normpdf(x,mu, sigma);
n((x<0 | x>11))= 1;

% Gaussian prior
%p2 = sum(log(normpdf(x,mu,sigma)));
 p2 = sum(log(n));

end