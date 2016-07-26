function comp_realk_calck
	% Plots the chosen k profile (October 9th, 21:59:00)
	load('Real_data_2015-10-09_T215900_10m','k_data','x_data');

	Tb = 11.7647;
	dx = 10;
	[h,x] = get_hOct9;
	[h_grid,x_grid] = interp_h(h,x,dx);

	k_synth = wavenumber(Tb, h_grid);

	figure (1)
	plot(x_grid,k_synth)
	hold on
	plot(x_data,k_data)
	x = xlabel('x Position (m)');
	y = ylabel('Wave Number');
	ylim([-0.1,0.3]);
	set(x,'Interpreter','Latex');
	set(y,'Interpreter','Latex');
	set(gca,'xdir','reverse');
	yyaxis('right')
	plot(x_grid,h_grid,'k');
	y2 = ylabel('Depth (m)');
	set(y2,'Interpreter','Latex');
	leg = legend('Calculated Wave Number','Measured Wave Number','October 9th Bathymetry');
	set(leg,'Interpreter','Latex');
	set(gca,'ydir','reverse');
	ylim([-10,12]);
	xlim([0,1150]);

end