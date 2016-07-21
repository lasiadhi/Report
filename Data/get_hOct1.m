function [h,x] = get_hOct1()
% This function pulls the transect data for the 1-D cross section of
% interest from a specified date in October 01, 2015.
%
% Transect is located at approximately y = 950 m.
%
% profileNumber of interest 951
% 
% NOTE: This survey is measured relative to NAVD88, the time of writing
% this code, I am not certain if a shift is needed but this function has
% the ability to incorporate one - it is currently set to zero.

    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/survey/transect/FRF_BD_20151001_0001_NAVD88_CRAB_GPS_UTC_v20151001.nc';
    profileNumber = ncread(filename, 'profileNumber');
    
    ii = find(profileNumber == 951);
    
    % potential shift
    shift = 0;
    
    x_org = ncread(filename, 'FRF_Xshore',min(ii),length(ii));
    elevation = ncread(filename, 'elevation', min(ii), length(ii));
    h_org = -1*(elevation + shift);
    
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