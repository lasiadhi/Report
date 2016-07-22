function plot2Dk
%{
Plot 2D k for the first measurement on October 1
%}
    k2D = get2Dk('2015-10-01 00:00:00','2015-10-01 11:30:00');
    k2D=permute(k2D,[2,3,1]);
    
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/BathyDuck-ocean_bathy_argus_201510.nc';
    xm = ncread(filename,'xm');
    ym = ncread(filename,'ym');

    % make missing values disappear into the ether
    k2D(k2D == -999.99) = NaN;
     

    [xgrd,ygrd]=meshgrid(ym,xm);
    figure
    clf
    surf(xgrd,ygrd,k2D);  hold on
    view(55, 35)
    y=xlabel('y (m)');
    x=ylabel('x (m)');
    z=zlabel('wave number, \textit{k}');
    %tit=title('Observed wave number on 1 October 2015');
    set(x,'Interpreter','Latex');
    set(y,'Interpreter','Latex');
    set(z,'Interpreter','Latex');
    %set(tit,'Interpreter','Latex');
    
    
    %plot profile of 1D model
    
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';
    ym = ncread(filename,'xm');
    xm = ones(length(xm),1)*950.;
    k1D=get1Dk();
    
    p=plot3(xm,ym,k1D(:,1),'LineWidth',8,'Color','r','Linestyle','-');
    legend(p,'Transect in 1D model','Location','northwest')
    print('figs/k2D','-dpng')

end
