function [griddata,date]=get2DtrueBath
%{
Read in 2D gridded bathymetry data from bathyduck/survey/gridded
FRF_BD_*_NAVD88_CRAB/LARC_GPS_UTC_*_grid

USAGE: 
griddata=get2DtrueBath

Output fields are: 
time
lat
lon
FRF_Xshore
FRF_Yshore
elevation

Cell arrays correspond to date of data collection:
d20151030
d20151023
d20151021
d20151019
d20151014
d20151008
d20151001


Output format is a structure of cell arrays. Reference the output like:

field = griddata.(cellArray){field index}
e.g.:
time  = griddata.(d20151001){1}

%}

    %params to construct filenames for October data
    date = [20151030,20151023,20151021,20151019,20151014,20151008,20151001];
    ptnum = [8,7,6,5,3,2,1];
    version = [20151030,20151028,20160104,20151030,20151019,20151009,20151001];
    instrument = ['CRAB';'CRAB';'LARC';'CRAB';'LARC';'CRAB';'CRAB'];

    griddata = struct;
    
    %Iterate over files (each containing 1 day of data), read select fields,
    %save to data structure with one cell array for each file's data
    for i = 1:length(date)

       filename = sprintf('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/survey/gridded/FRF_BD_%d_%04d_NAVD88_%s_GPS_UTC_v%d_grid.nc',date(i),ptnum(i),instrument(i,:),version(i));
       fieldname = sprintf('d%04d',date(i));

       time = ncread(filename,'time');
       lat = ncread(filename,'lat');
       lon = ncread(filename,'lon');
       FRF_Xshore = ncread(filename,'FRF_Xshore');
       FRF_Yshore = ncread(filename,'FRF_Yshore');
       elevation = ncread(filename,'elevation');

       value = {time,lat,lon,FRF_Xshore,FRF_Yshore,elevation};
       griddata(:).(fieldname) = deal(value);
    end
end
