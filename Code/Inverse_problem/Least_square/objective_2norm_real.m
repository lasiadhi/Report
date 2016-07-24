function f = objective_2norm_real(h)

load('Real_data_2015-10-09_21:59:00_10m.mat','k_data','x_dat');   % load real k_data

[k_appro, H] = forward(h);

f =  norm(k_appro - k_noisy)^2 +  3e-7 * norm(h)^2;

end