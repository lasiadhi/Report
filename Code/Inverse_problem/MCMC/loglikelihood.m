function l = loglikelihood(k1D, kFor, sigk)
%{
Expression for the likelihood function with objective k (wave number)

%}
%p1 = log(exp(-(sum((noisy_data - ODE_sol(alpha,xvec)).^2)./(2 * sigma0^2))));

l = -sum((k1D - kFor).^2)./(2*sigk^2);


end
