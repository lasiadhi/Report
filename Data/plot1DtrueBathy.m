function plot1DtrueBathy
% This function plots the 1D true bathymetry
    
    % call in elevations and populate water levels
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/survey/transect/FRF_BD_20151001_0001_NAVD88_CRAB_GPS_UTC_v20151001.nc';
    profileNumber = ncread(filename, 'profileNumber');
    ii = find(profileNumber == 951);
    z = ncread(filename, 'elevation',min(ii),length(ii));
    z = flipud(z);
    for i = 1:length(ii)
        water_level(i) = 0.156;
    end
    
    % call h and x data
    [h,x] = get_hOct1;
    
    % discretize h and x
    [hgrid,xgrid] = interp_h(h,x,10);
    
    figure
    subplot(1,2,1)
    plot(x,z,'r','LineWidth',2);
    hold on
    plot(x,water_level,'k-.','LineWidth',2);
    ylim([-12.844,3.156]);
    xlim([0,1500]);
    set(gca,'Xdir','reverse');
    legend('Survey Data','Survey Water Level');
    xlabel('x Position (meters)');
    ylabel('Elevation (meters)');
    title('Elevation');
    
    subplot(1,2,2)
    plot(xgrid,hgrid,'--','LineWidth',2);
    hold on
    plot(x,h,'LineWidth',2);
    ylim([-3,13]);
    xlim([0,1500]);
    set(gca,'Xdir','reverse');
    set(gca,'Ydir','reverse');
    legend('Interpolated/Extrapolated Data','Survey Data');
    xlabel('x Position (meters)');
    ylabel('Depth (meters)');
    title('Depth');
    
    
end