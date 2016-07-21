function plot2DBath
%{
Plot 2D Bathymetry data in lat/lon coordinates. For either one or many
dates when we have data. Current setup is for only plotting Oct 1.
%}
    %get bathymetry data
    [bathdata,date]=get2DtrueBath;

    %2D bathymetry data in lat/lon
    figure(1)
    clf
    for i=length(date):length(date)
        hold on;
        fieldname = sprintf('gd%04d',date(i));
        surf(bathdata.(fieldname){2},bathdata.(fieldname){3},bathdata.(fieldname){6})
        xlabel('latitude (\circ)')
        ylabel('longitude (\circ)')
        zlabel('depth (m)')
        datestr=num2str(date(i));
        titstr = sprintf('True bathymetry for %s October 2015',datestr(end-1:end));
        title(titstr)
    end
end