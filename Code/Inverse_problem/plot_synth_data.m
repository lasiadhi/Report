function plot_synth_data

	load('k_1percNoisedata_N47.mat','k_noisy');
	load('Real_data_2015-10-09_T215900_10m.mat','k_data','x_data');
	[h,x] = get_hOct1;
	[hgrid,xgrid] = interp_h(h,x,25);

	plot(xgrid, k_noisy);
	hold on
	ylabel('Wave Number');
	yyaxis('right');
	plot(xgrid,hgrid);
	ylabel('Depth (m)');
	xlim([0,1150]);
	set(gca,'xdir','reverse');
	set(gca,'ydir','reverse');
	ylim([-10,12]);
	xlabel('x Position (m)');
	title('Manufactured Data');
	legend('Manufactured Wave Number','Bathymetry');


end