function dat = getBC(var,startT,endT)
% This function gets the boundary conditions for the 1-D forward problem
% time_coverage_start: 2015-10-01 00:00:02
% time_coverage_end: 2015-10-31 23:00:03
% 
% Data time-step: hourly
% Data is produced via a 34 minute timeseries analysis.
%
% See below the function for possible var values.
% 
%-------------------------------------------------------------------------
% FORMAT NOTE: 
%
% var - must be entered in quotes (i.e. 'waveHs')
%
% starT and endT - must be input in 'yyyy-mm-dd' (IN QUOTES)
%-------------------------------------------------------------------------
% Start/End time NOTE:
%
%

    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc';
    
    if nargin == 3 
        % if startT and endT are provided
        % NOTE: This is currently broken!!!!!!!!!!!!!!!!!!!!!!!!!
        formatIn = 'yyyy-mm-dd';
        datenum_start = datenum(startT,formatIn);
        datenum_end = datenum(endT,formatIn);
        
        time = ncread(filename,'time');
        
        
        ii = find(and(time >= datenum_start, time <= datenum_end)); 
        dat = ncread(filename,var,min(ii),length(ii));
    elseif nargin == 1
        % if only variable type is provided
        dat = ncread(filename,var);
    else
        errormessage = ('Improper amount of input arguments. Either soley input the desired variable, or the desired variable, a start time, and end time');
        error(errormessage)
    end

end