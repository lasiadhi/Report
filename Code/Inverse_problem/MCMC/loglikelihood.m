function l = loglikelihood(kdat, kFor, vark)
%{
Expression for the likelihood function with objective k (wave number)

%}
%p1 = log(exp(-(sum((noisy_data - ODE_sol(alpha,xvec)).^2)./(2 * sigma0^2))));


l = -sum((kdat - kFor).^2)./(2*vark);

end
