function k = get2Dk(startT,endT)
%{
USAGE:
k = get2DK('2015-10-01 00:00:00','2015-10-31 23:00:00')

This function extracts the wave number, k, from argus data on an x/y grid
file time coverage start: 2015-09-24 11:29:00
file time coverage end: 2015-11-03 22:59:00
Note: The function allows only October data to be extracted

Data time-step: hourly
Data is produced via a 34 minute timeseries analysis.

See below the function for possible var values.

-------------------------------------------------------------------------
FORMAT NOTE: 

var - must be entered in quotes (i.e. 'waveHs')
starT and endT - must be input in 'yyyy-mm-dd HH-MM-SS' (IN QUOTES)
-------------------------------------------------------------------------
%}
    %Iterate over data files, read select fields,save to data structure with 
    %one cell array for each file's data

    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';

    if nargin == 0 || nargin == 2
    else
        errormessage = ('Improper amount of input arguments. Function requires start AND end time or no arguments.');
        error(errormessage)
    end
    
    if nargin == 0 %no start/end time provided
        startT = '2015-10-01 00:00:00';
        endT = '2015-10-31 23:59:59';
    end

    % http://chlthredds.erdc.dren.mil/ data is recorded in seconds from
    % 1970-01-01 00:00:00, while matlabs datenum function measures days
    % from 0000-01-01 00:00:00, thus the dates must be converted.

    form = 'yyyy-mm-dd HH:MM:SS';
    datenum_conv = datenum('1970-01-01 00:00:00',form);
    converted_start = (datenum(startT,form)-datenum_conv)*3600*24; % convert to seconds
    converted_end = (datenum(endT,form)-datenum_conv)*3600*24;

    if converted_start < 1.44365759e9 || converted_end > 1.446336e9
        errormessage = ('Your start or end time is outside October. Select input values for startT and endT that are between 2015-10-01 00:00:00 and 2015-10-31 23:59:59');
        error(errormessage)
    end

    time = ncread(filename,'time');
    ii = find(and(time >= converted_start, time <= converted_end)); 

    first = [1,1,1,min(ii)];
    last =  [1,Inf,Inf,length(ii)];
    
    k = ncread(filename,'k',first,last);

    actual_start = time(min(ii))/(3600*24) + datenum_conv;
    actual_start_str = datestr(actual_start,form);

    disp('Note: Actual start time:')
    disp(actual_start_str)

end