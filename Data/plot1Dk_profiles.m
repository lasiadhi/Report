function plot1Dk_profiles(startT,endT)
% This program creates a time series plot of the k values along our 1-d
% transect between specified values.
%
% file time coverage start: 2015-09-24 11:29:00
% file time coverage end: 2015-11-03 22:59:00
% COPY FORMAT ABOVE.
%
% Usage statement:
% plot1Dk_profiles('2015-10-09 12:00:00', '2015-10-19 23:59:59')
%
% This script was used to pick a "suitable" wave number profile; the wave
% number profile chosen is '2015-10-09 21:59:00'.

    [k,x_k] = get1Dk(startT, endT);
    
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/BathyDuck-ocean_bathy_argus_201510.nc';
    form = 'yyyy-mm-dd HH:MM:SS';
    datenum_conv = datenum('1970-01-01 00:00:00',form);
    converted_start = (datenum(startT,form)-datenum_conv)*3600*24; % convert to seconds
    converted_end = (datenum(endT,form)-datenum_conv)*3600*24;
    time = ncread(filename,'time');
    ii = find(and(time >= converted_start, time <= converted_end));
    time_sub = time(min(ii):max(ii));
    
    time_sub_str = cell(length(ii),1);
    time_sub_tmp = zeros(length(ii));
        % convert to matlab time
        for i = 1:length(ii)
            time_sub_tmp(i) = time_sub(i)/(3600*24) + datenum_conv;
            time_sub_str{i} = datestr(time_sub_tmp(i),form);
        end
    
    figure
    plot(x_k,k);
    xlabel('x location(m)');
    xlim([0,1150])
    set(gca,'Xdir','reverse')
    ylabel('Wave Number');
    Titlep1 = 'Dominant Wave Number Profiles from:';
    Titlep2 = 'to';
    Title = [Titlep1,' ',startT,' ',Titlep2,' ',endT];
    title(Title);
    legend(time_sub_str)
end