function f = objective_2norm(h)

% load('k_2_5percNoisedata.mat','k_noisy');   % load k_noisy data

  load('k_1percNoisedata_N47.mat','k_noisy');   % load k_noisy data

[k_appro, H] = forward(h);

%f =  norm(k_appro - k_noisy)^2 +  1e-7 * norm(h)^2;


    len = length(h);
    lambda = zeros(len,1);
    lambda(1:ceil(len/2))     = 1e-9;
    lambda(ceil(len/2)+1:end) = 1e-7; 
    
f =  norm(k_appro - k_noisy)^2 +  +  norm(sqrt(lambda) .* h)^2;

end