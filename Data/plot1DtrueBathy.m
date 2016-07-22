function plot1DtrueBathy
% This function plots the 1D true bathymetry
    
    % call in elevations and populate water levels
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/survey/transect/FRF_BD_20151001_0001_NAVD88_CRAB_GPS_UTC_v20151001.nc';
    profileNumber = ncread(filename, 'profileNumber');
    ii = find(profileNumber == 951);
    z = ncread(filename, 'elevation',min(ii),length(ii));
    z = fliplr(z);
    for i = 1:length(ii)
        water_level(i) = 0.156;
    end
    
    % call h and x data
    [h,x] = get_hOct1;
    
    % discretize h and x
    [hgrid,xgrid] = interp_h(h,x,10);
    
    figure
    hold on
    subplot(1,2,1)
    plot(x,z);
    plot(x,water_level,'k-.','lineweight',2);
    
end