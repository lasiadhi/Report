

function p2 = myprior(x)

% known values
mu    = 0;
sigma = 1;

%% bounded h
% x(x<0) = 1e+10;
% x(x>11) = 1e+10;
%%

% Gaussian prior
n = normpdf(x,mu,sigma);
n((x<0 | x>11))=1;


p2 = sum(log(n));

end