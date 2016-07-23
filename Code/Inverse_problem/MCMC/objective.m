function f = objective(h)

load('k_2_5percNoisedata.mat','k_noisy');   % load k_noisy data

[k_appro, H] = forward(h);
f =  k_appro - k_noisy;

end