function k1D=get1Dk()
%{
File to get 1D profile

OUTPUT:
k1D has dimensions nx by ntime with NAN for missing values

USAGE:
k1D=get1Dk()
%}
    % get 2D data
    k2D = get2Dk();
    
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';
    ym = ncread(filename,'ym');
    
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