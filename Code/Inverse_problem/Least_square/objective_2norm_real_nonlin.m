function f = objective_2norm_real_nonlin(h)

	load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');   % load real k_data
	dx = x_data(2) - x_data(1); % resolution defined by data grid

	[k_appro, H] = forward_real_nonlin(h,dx);

	num = 1;
	for i = 1:size(k_data)
		if ~isnan(k_data(i))
			k_appro_subset(num) = k_appro(i);
			k_data_subset(num)	= k_data(i);
			h_subset(num) 		= h(i);
			num 				= num + 1;
		else	
		end
    end
    
    len = length(h);
    lambda = zeros(1,len);
    lambda(1:ceil(len/2)) = 3e-7;
    lambda(ceil(len/2)+1:end) = 3e-5;

	%f =  norm(k_appro_subset - k_data_subset)^2 +  (3e-7)*norm(h_subset)^2;
	f =  norm(k_appro_subset - k_data_subset)^2 +  norm((sqrt(lambda))'.*h)^2;

end