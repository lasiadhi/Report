function f = objective_2norm_real(h)

<<<<<<< HEAD
	load('Real_data_2015-10-09_21:59:00_10m.mat','k_data','x_data');   % load real k_data
=======
	load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');   % load real k_data
>>>>>>> 6cc1b8dd0429d740d9277095c093bb92c66cf4c0
	dx = x_data(2) - x_data(1); % resolution defined by data grid

	[k_appro, H] = forward_real(h,dx);

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

	f =  norm(k_appro_subset - k_data_subset)^2 +  3e-7 * norm(h_subset)^2;

end