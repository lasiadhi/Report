%{
Reading in bathymetric survey data collected by the BathyDuck Product at
ERDC. Includes data at the boundary condition pt and from the beach-mounted
video.

Data comes directly from the url
http://chlthredds.erdc.dren.mil/thredds/catalog/frf/projects/bathyduck/data/catalog.html

%}

%% Boundary Condition Data %% 
% Load in Boundary Condition data from bathyduck/data 
% FRF-ocean_waves_awac04_201510

bc.time=ncread('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc?waveHs[0:1:644],wavePeakFrequency[0:1:644],time[0:1:644],depth[0:1:0],lat,lon','time');
bc.waveHs=ncread('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc?waveHs[0:1:644],wavePeakFrequency[0:1:644],time[0:1:644],depth[0:1:0],lat,lon','waveHs');
bc.wavePeakFrequency=ncread('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc?waveHs[0:1:644],wavePeakFrequency[0:1:644],time[0:1:644],depth[0:1:0],lat,lon','wavePeakFrequency');
bc.depth=ncread('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc?waveHs[0:1:644],wavePeakFrequency[0:1:644],time[0:1:644],depth[0:1:0],lat,lon','depth');
bc.lat=ncread('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc?waveHs[0:1:644],wavePeakFrequency[0:1:644],time[0:1:644],depth[0:1:0],lat,lon','lat');
bc.lon=ncread('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc?waveHs[0:1:644],wavePeakFrequency[0:1:644],time[0:1:644],depth[0:1:0],lat,lon','lon');

%% Bathy Data %%
% Load in bathymetric data from bathyduck/data
% BathyDuck-ocean_bathy_p*_201510
% Note: * changes
% Result: data structure with a cell array for each data point/file

%The following are for identifying the filename and individual data points
point_input = [04,11,12,13,14,22,23,24,83]';
max_ind_input = [6931,5497,5493,3047,3908,5452,5450,4014,5165];

%Create an empty structure
bathydata = struct;

%Iterate over files (each containing 1 spatial data pt), read select fields,
%save to data structure with one cell array for each file's data
for i = 1:length(point_input)
    filename = sprintf('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_p%02d_201510.nc?time[0:1:%d],xloc,yloc,seafloorLocation[0:1:%d]',point_input(i),max_ind_input(i),max_ind_input(i));
    fieldname = sprintf('p%02d',point_input(i));
    
    time = ncread(filename,'time');
    xloc = ncread(filename, 'xloc');
    yloc = ncread(filename, 'yloc');
    seafloorLocation = ncread(filename, 'seafloorLocation');
    
    value = {time, xloc, yloc, seafloorLocation};
    
    bathydata(:).(fieldname) = deal(value);
end 

%% Wave Data %%
% Load in wave data from bathyduck/data
% Bathyduck-ocean_waves_p*_201510

%Params for getting filenames, identifying pts
point_input = [11,12,13,14,21,22,23,24,83,84];
max_ind_input = [474,451,474,474,450,450,473,451,426,357];

%Intitiate empty data structure
wavedata = struct; 

%Iterate over files (each containing 1 spatial data pt), read select fields,
%save to data structure with one cell array for each file's data
for i = 1:length(point_input)
   filename = sprintf('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_waves_p%02d_201510.nc?time[0:1:%d],zloc[0:1:%d],waveHs[0:1:%d],waveHsArray[0:1:%d][0:1:5],xloc[0:1:%d],yloc[0:1:%d]',point_input(i),max_ind_input(i),max_ind_input(i),max_ind_input(i),max_ind_input(i),max_ind_input(i),max_ind_input(i));
   fieldname = sprintf('p%02d',point_input(i));
   
   time = ncread(filename,'time');
   zloc = ncread(filename,'zloc');
   waveHs = ncread(filename, 'waveHs');
   waveHsArray = ncread(filename, 'waveHsArray');
   xloc = ncread(filename, 'xloc');
   yloc = ncread(filename, 'yloc');
   
   value = {time, zloc, waveHs, waveHsArray, xloc, yloc};
   wavedata(:).(fieldname) = deal(value);
end

%% Spatial Check %%
% plot the various x and y locations for wave and bathy data

% wave points -- x and y arrays
point_input = [11,12,13,14,21,22,23,24,83,84];
for i = 1:length(point_input)
    fieldname = sprintf('p%02d',point_input(i));
    x_wave(i) = wavedata.(fieldname){5}(1);
    y_wave(i) = wavedata.(fieldname){6}(1); 
end

% bathymetry points -- x and y arrays
point_input = [04,11,12,13,14,22,23,24,83]';
for i = 1:length(point_input) 
    fieldname = sprintf('p%02d',point_input(i));
    x_bathy(i) = bathydata.(fieldname){2};
    y_bathy(i) = bathydata.(fieldname){3};
end

%plot x and y locations of wave and bathy data
figure (1)
hold on
scatter(x_bathy,y_bathy,'b','s');
scatter(x_wave,y_wave,'r','p');
xlabel('x-location');
ylabel('y-location');
title('Spatial Check');
legend('Bathy Points', 'Wave Points','location','northwest');

%% True bathymetry data
% Load in gridded bathymetry data from bathyduck/survey/gridded
% FRF_BD_*_NAVD88_CRAB/LARC_GPS_UTC_*_grid

%params to piece together filenames for reading data
date = [20151030,20151023,20151021,20151019,20151014,20151008,20151001];
ptnum = [8,7,6,5,3,2,1];
version = [20151030,20151028,20160104,20151030,20151019,20151009,20151001];
max_ind_lat = [32,41,58,41,57,41,11];
max_ind_lon = [59,55,71,55,192,54,54];
instrument = ['CRAB';'CRAB';'LARC';'CRAB';'LARC';'CRAB';'CRAB'];

%Iterate over files (each containing 1 spatial data pt), read select fields,
%save to data structure with one cell array for each file's data
for i = 1:length(date)
   
   filename = sprintf('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/survey/gridded/FRF_BD_%d_%04d_NAVD88_%s_GPS_UTC_v%d_grid.nc?time[0:1:0],lat[0:1:%d],lon[0:1:%d],FRF_Yshore[0:1:%d],FRF_Xshore[0:1:%d],elevation[0:1:0][0:1:%d][0:1:%d]',date(i),ptnum(i),instrument(i,:),version(i),max_ind_lat(i),max_ind_lon(i),max_ind_lat(i),max_ind_lon(i),max_ind_lat(i),max_ind_lon(i));
   fieldname = sprintf('gd%04d',ptnum(i));
    
   time = ncread(filename,'time');
   lat = ncread(filename,'lat');
   lon = ncread(filename,'lon');
   FRF_Xshore = ncread(filename,'FRF_Xshore');
   FRF_Yshore = ncread(filename,'FRF_Yshore');
   elevation = ncread(filename,'elevation');
   
   value = {time,lat,lon,FRF_Xshore,FRF_Yshore,elevation};
   surveydata(:).(fieldname) = deal(value);
end

%% Plotting true bathymetry
% Grid and plot an x/y grid of the true bathymetry measured by CRAB/LARC
figure(2)
clf
%select data from structure
ptnum = [8,7,6,5,3,2,1];
for i=1:length(ptnum)
    hold on;
    fieldname = sprintf('gd%04d',ptnum(i));
    [Xgrd,Ygrd]=meshgrid(surveydata.(fieldname){6});
    plot(Xgrd,Ygrd,'.')
end


%% Video data 
%Load and organize "argus" data including k and f

%params to id urls with data files
date = {'201602','201601','201512','201511','201510_08','201510'};
ntime=[600,701,734,734,23,953];

%Iterate over data files, read select fields,save to data structure with 
%one cell array for each file's data
for i=1:length(date)
    datei = date{i};
    filename = sprintf('http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_%s.nc?time[0:1:%d],xm[0:1:72],ym[0:1:80],depth[0:1:0][0:1:0][0:1:0],depthKF[0:1:0][0:1:0][0:1:0],depthKFError[0:1:0][0:1:0][0:1:0],fB[0:1:%d][0:1:80][0:1:72][0:1:3],k[0:1:%d][0:1:80][0:1:72][0:1:3]',datei,ntime(i),ntime(i),ntime(i));
    fieldname= sprintf('d%s',datei);
    
    time = ncread(filename,'time');
    xm = ncread(filename,'xm');
    ym = ncread(filename,'ym');
    depth = ncread(filename,'depth');
    depthKF = ncread(filename,'depthKF');
    depthKFError = ncread(filename,'depthKFError');
    fB = ncread(filename,'fB');
    k = ncread(filename,'k');
    
    value = {time,xm,ym,depth,depthKF,depthKFError,fb,k};
    argusdata(:).(fieldname) = deal(value);
    
end