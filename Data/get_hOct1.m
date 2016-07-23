function [h,x] = get_hOct1()
% This function pulls the transect data for the 1-D cross section of
% interest from a specified date in October 01, 2015.
%
% Transect is located at approximately y = 950 m.
%
% profileNumber of interest 951
%-------------------------------------------------------------------------
% USAGE STATEMENT:
% [h,x] = get_hOct1
%-------------------------------------------------------------------------

    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/survey/transect/FRF_BD_20151001_0001_NAVD88_CRAB_GPS_UTC_v20151001.nc';
    profileNumber = ncread(filename, 'profileNumber');
    
    ii = find(profileNumber == 951);
    
    % water level shift
    % --------------------------------------------------------------------
    % Time of survey: 19:25:48 UTC (October 1st 2015)
    % Tide data taken from:
    % https://tidesandcurrents.noaa.gov/waterlevels.html?id=8651370&units=metric&bdate=20151010&edate=20151011&timezone=GMT&datum=NAVD&interval=6&action=
    % Time of measurement: 19:24 GMT
    water_level = 0.156; % NAVD88
    
    x_org = ncread(filename, 'FRF_Xshore',min(ii),length(ii));
    elevation = ncread(filename, 'elevation', min(ii), length(ii));
    h_org = -1*(elevation - water_level);
    
    % flip the vector to account for model co-orinate system, where the
    % boundary condition is at x = 0 and not at x = 1150 m.
    delta = 1150 - x_org(length(ii));
    x(1) = delta;
    h(1) = h_org(length(ii));
    
    for i = 2:length(ii)-1
        delta = x_org(length(ii)-(i-1)) - x_org(length(ii)-i);
        x(i) = x(i-1) + delta;
        h(i) = h_org(length(ii)-i);
    end
    
    % replace negative values with 0
    h(h<0) = 0;
end