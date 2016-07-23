function f = objective_2norm(h)

load('k_1percNoisedata_N47.mat','k_noisy');   % load k_noisy data

[k_appro, H] = forward(h);

f =  norm(k_appro - k_noisy)^2 +  1e-9 * norm(h)^2;

end