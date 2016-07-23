function f = objective_2norm(h)

load('k_2_5percNoisedata.mat','k_noisy');   % load k_noisy data

[k_appro, H] = forward(h);
f =  norm(k_appro - k_noisy);

end