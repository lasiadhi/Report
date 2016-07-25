function k_nonlin = nonlin_wavenumber(Tb,h,H,k)

	% --------------------- Constants -------------------------- %
	g = 9.8;        % unit (m/s2)

	% ------------------------- INPUT -------------------------- %
	% Tb: wave period at boundary 
	% h: vector of depth (dimension as grid point, unit as meter)
	% H: wave height calculated from the forward model
	% k: linear wave number (used for initial guess of the solver)

	% ------- Dispersion equation ------------------------------ %
	% af^2 	=  g*k*(1 + f_1*eps^2*D) tanh(k*h + f_2*eps)
	% where:
	% D 	= (8 + cosh(4*k*h - 2 tanh^2(k*h)))/(8*sinh^4(k*h))
	% f_1 	= tanh^5(k*h)
	% f_2	=((k*h)/sinh(k*h))^4
	% eps = k*H/2 
	% ---------------------------------------------------------- %

	% ------ Number of grid point ------------------------------ %
	N1 = length(h);

	% ----- af: angular fruquency ------------------------------ %
	af = 2*pi/Tb;

	% ----- Initialize k vector -------------------------------- %
	k_nonlin = zeros(N1, 1);

	for i = 1:N1
		if h(i) ~= 0
			options = optimset('Display','off');
			k0 = k(i);
			hh = h(i);
			HH = H(i);
			fct = @(kk) (((g*kk)*(1 + (tanh(kk*hh)^5)*((kk*HH/2)^2)...
				*(8 + cosh(4*kk*hh - 2*tanh(kk*hh)))/(8*((sinh(kk*hh))^4)))...
				*tanh(kk*hh + (((kk*hh)/sinh(kk*hh))^4)*kk*HH/2)) - af^2);
			kk = fsolve(fct,k0,options);
			%kk = fsolve(fct,k0);
			k_nonlin(i) = kk;
		else
			k_nonlin(i) = 0;
		end
	end
end

