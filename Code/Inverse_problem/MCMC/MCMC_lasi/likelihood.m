

function p1 = likelihood(noisy_data, h_guess, sigma0)

[k_appro, H] = forward(h_guess);
p1           = -(sum((noisy_data - k_appro).^2)/(2 * sigma0^2));


end
