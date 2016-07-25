function f = objective_real(h)

 load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');   % load real k_data
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
    
%     len = length(h_subset);
%     lambda = zeros(1,len);
%     lambda(1:ceil(len/2)) = 3e-5;
%     lambda(ceil(len/2)+1) = 3e-7;
%     
    f =  k_appro_subset - k_data_subset;

end