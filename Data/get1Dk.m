function [k1D,x_k]=get1Dk(startT,endT)
%{
File to get 1D profile of wave number. The x coordinate has been aligned with the model coordinates, such that x=0
is located off shore.


OUTPUT:
-k1D has dimensions nx by ntime with NAN for missing values
-x_k gridded x-locations of the wave number is optional

USAGE:
k1D=get1Dk()
k1D = get1Dk('2015-10-01 00:00:00','2015-10-31 23:00:00')
[k1D,x_k] = get1Dk

file time coverage start: 2015-09-24 11:29:00
file time coverage end: 2015-11-03 22:59:00
Note: The function allows only October data to be extracted
Data time-step: hourly
Data is produced via a 34 minute timeseries analysis.
See below the function for possible var values.
-------------------------------------------------------------------------
FORMAT NOTE: 
starT and endT (optional)- must be input in 'yyyy-mm-dd HH:MM:SS' (IN QUOTES)

%}
    if nargin == 0 %no start/end time provided
        startT = '2015-10-01 00:00:00';
        endT = '2015-10-31 23:59:59';
    end
        
    [k2D,~] = get2Dk(startT,endT);
    
    %filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/BathyDuck-ocean_bathy_argus_201510.nc';

    ym = ncread(filename,'ym');

    xorig = ncread(filename,'xm');
    xmax = 1150 - min(xorig);
    xmin = xmax - range(xorig);
    x_k = [xmin:10:xmax]';
    
    
    % find the indices corresponding to y=950m
    transect_yind = find(ym==950,1);
    
    % use only first k val (of 4) and the x and time where y=950m
    %this is probably wrong right now because the y dimension should drop
    %out
    k1D = k2D(1,:,transect_yind,:);
    
    % reorder the indices to be (x,time)
    k1D = permute(k1D,[2,4,1,3]);
    
    % make missing values = nan
    k1D(k1D == -999.99) = NaN;

end