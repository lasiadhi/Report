

function p1 = likelihood(noisy_data, alpha, sigma0, xvec)


p1 = log(exp(-(sum((noisy_data - ODE_sol(alpha,xvec)).^2)./(2 * sigma0^2))));


end
