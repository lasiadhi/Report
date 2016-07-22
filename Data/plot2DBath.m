function plot2DBath
%{
Plot 2D Bathymetry data in lat/lon coordinates. For either one or many
dates when we have data. Current setup is for only plotting Oct 1.

USAGE:
plot2DBath
%}
    %get bathymetry data
    [bathdata,date]=get2DtrueBath;

    %2D bathymetry data in lat/lon
    figure
    clf
    for i=length(date):length(date)
        hold on;
        grid on;
        fieldname = sprintf('d%04d',date(i));
        surf(bathdata.(fieldname){2},bathdata.(fieldname){3},bathdata.(fieldname){6})
        xlabel('latitude (\circ)')
        ylabel('longitude (\circ)')
        zlabel('elevation (m)')
        datestr=num2str(date(i));
        titstr = sprintf('True bathymetry for %s October 2015',datestr(end-1:end));
        title(titstr)
    end
    
    
    % show 1D profile on 2D surface
    % get indices for FRF_Yshore = 950m 
    transect_yind = find(bathdata.(fieldname){5}==951.203,1);
    % show lat/lon corresponding to indices where FRF_Yshore = 950
    bathprofile_lat = bathdata.(fieldname){2}(transect_yind);
    %make it a vector of the one value for plotting
    bathprofile_lat_vector = ones(55,1)*bathprofile_lat;
    % draw line with z=elevation at indices where FRF_Yshore = 950
    p=plot3(bathprofile_lat_vector,bathdata.(fieldname){3},bathdata.(fieldname){6}(:,transect_yind),'LineWidth',8,'Color','r','Linestyle','-');
    legend(p,'Transect in 1D model','Location','northwest')
    
    
end