function T1D=get1DT()
%{
File to get 1D profile of wave period (as derived from wave frequency, fB
measured by the argus video). 

OUTPUT:
T1D has dimensions nx by ntime with NAN for missing values

USAGE:
T1D=get1DT()
%}
    T2D = get2DT();
    
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';
    ym = ncread(filename,'ym');
    
    % find the indices corresponding to y=950m
    transect_yind = find(ym==950,1);
    
    % use only first T val (of 4) and the x and time where y=950m
    %this is probably wrong right now because the y dimension should drop
    %out
    T1D = T2D(1,:,transect_yind,:);
    
    % reorder the indices to be (x,time)
    T1D = permute(T1D,[2,4,1,3]);
    
    % make missing values = nan
    T1D(T1D == -999.99) = NaN;
end