function dat = getBC(var,startT,endT)
% This function gets the boundary conditions for the 1-D forward problem
% time_coverage_start: 2015-10-01 00:00:02
% time_coverage_end: 2015-10-31 23:00:03
% 
% Data time-step: hourly
% Data is produced via a 34 minute timeseries analysis.
%
% To get boundary conditions for October 1st, run getBC with:
% startT: '2015-10-01 00:00:00'
% endT: '2015-10-02 00:00:00'
% and select the first index.
%
% To get boundary conditions for October 9th, run getBC with:
% startT: '2015-10-09 20:00:00'
% endT: '2015-10-10 01:00:00'
% and select the first index. This will select values corresponding to 
% 2015-10-09 22:00:08, which is quite close to our measured k profile, 
% which is taken at 2015-10-09 21:59:00.
%
% See below the function for possible var values.
%-------------------------------------------------------------------------
% USAGE STATEMENT:
% H = getBC('waveHs', '2015-10-01 00:00:00', '2015-10-02 00:00:00')
%
% or with no dates
% H = getBC('waveHs')
%
%-------------------------------------------------------------------------
% FORMAT NOTE: 
%
% var - must be entered in quotes (i.e. 'waveHs')
% starT and endT - must be input in 'yyyy-mm-dd HH-MM-SS' (IN QUOTES)
%-------------------------------------------------------------------------

    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc';
    
    if nargin == 3 
        % if startT and endT are provided
        % 
        % http://chlthredds.erdc.dren.mil/ data is recorded in seconds from
        % 1970-01-01 00:00:00, while matlabs datenum function measures days
        % from 0000-01-01 00:00:00, thus the dates must be converted.
        
        format = 'yyyy-mm-dd HH:MM:SS';
        datenum_conv = datenum('1970-01-01 00:00:00',format);
        converted_start = (datenum(startT,format)-datenum_conv)*3600*24; % convert to seconds
        converted_end = (datenum(endT,format)-datenum_conv)*3600*24;
        
        time = ncread(filename,'time');
        ii = find(and(time >= converted_start, time <= converted_end)); 
        
        dat = ncread(filename,var,min(ii),length(ii));
        
        actual_start = time(min(ii))/(3600*24) + datenum_conv;
        actual_start_str = datestr(actual_start,format);
        
        %disp('Note: Actual start time:')
        %disp(actual_start_str)
        
    elseif nargin == 1
        % if only variable type is provided
        dat = ncread(filename,var);
    else
        % out put error message 
        errormessage = ('Improper amount of input arguments. Either soley input the desired variable, or the desired variable, a start time, and end time. See getBC.m for notes on formats.');
        error(errormessage)
    end

end
% Possible var values
% -----------------------
% waveHs
% wavePeakFrequency
% station_name
% wavePeakDirectionPeakFrequency
% waveEnergyDensity
% directionalWaveEnergyDensity
% waveFrequency
% waveDirectionBins
% time
% depth
% depthP
% lat
% lon
% qcFlagE
% qcFlagD
% directionalPeakSpread
% spectralWidthParameter
% waveDirectionEstimator
% waveA1Value
% waveB1Value
% waveA2Value
% waveB2Value