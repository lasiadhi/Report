function [k_data,x_data] = get1Dk_profile(timestamp)
% This script creates a data vector of wave numbers along the 1D transect
% according to the input timestamp.
%
% At the moment, the default wave number profile chosen is 
% '2015-10-09 21:59:00' as it is close to a recent survey (on October 9th) 
% and seems to be considerably less noisy than other profiles around the 
% same time and doesn't have many NaN values.
%
% To extract this time stamp use:
% [k_data, x_data] = get1Dk_profile('2015-10-09 21:59:00');
% or
% [k_data, x_data] = get1Dk_profile;
%-------------------------------------------------------------------------

    if nargin == 0
        timestamp = '2015-10-09 21:59:00'; % default wave number prof
    end
    
    [k,x_data] = get1Dk;
    
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/BathyDuck-ocean_bathy_argus_201510.nc';
    
    % time conversions
    form = 'yyyy-mm-dd HH:MM:SS';
    datenum_conv = datenum('1970-01-01 00:00:00',form);
    time = ncread(filename,'time');
    prof_datenum = datenum(timestamp,form);
    converted_prof_datenum = (prof_datenum-datenum_conv)*3600*24 % convert to seconds

    ii = find(and((time >= converted_prof_datenum - 15*60),(time <= converted_prof_datenum + 15*60)));
    
    k_data = k(:,ii);
    
end