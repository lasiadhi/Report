function wavenumbercomparisonPlot
	% This creates a plot of a comparison of the linear and non-linear
	% wave number and the resulting wave heights.

	dx = 10;
	[h,x] = get_hOct9;
	[hgrid,xgrid] = interp_h(h,x,dx);

	Hmax = 0.6663;
	Tb = 11.7647;

	% Get linear wave number
	k = wavenumber(Tb,hgrid);

	for i = 1:3
		H = waveheight_H_modified(Hmax,hgrid,Tb,k,dx);

		figure (1)
		subplot(2,1,1)
		plot(xgrid,k)
		hold on
		xlim([0,1150]);
		set(gca,'xdir','reverse');
		xlabel('x Position(m)');
		ylabel('Wave Number');
		title('Wave Number');

		subplot(2,1,2)
		hold on
		plot(xgrid,H)
		xlim([0,1150]);
		set(gca,'xdir','reverse');
		xlabel('x Position(m)');
		ylabel('Wave Height (m)');
		title('Wave Height');

		k = nonlin_wavenumber(Tb,hgrid,H,k);
	end

	hold on
	subplot(2,1,1)
	legend('Linear Wave Number','Non-Linear Wave Number iter 1','Non-Linear Wave Number iter 2')
	hold on
	subplot(2,1,2)
	legend('Linear Wave Number Result','Non-Linear Wave Number iter 1 Result','Non-Linear Wave Number iter 2 Result' )
end 