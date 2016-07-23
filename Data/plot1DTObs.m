function plot1DTObs
%{
Plot mean and standard deviation of k along y=950m transect
 
USAGE:
plot1DkObs
%}
    %get the x values
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';
    xm = ncread(filename,'xm');
    
    % get mean and variance of 1D k values over time
    [T1Dmean,T1Dstd]=get1DTStats();
    
    % access matlab functions below
    addpath('mfunc/confplot')
    
    %plot mean with +/- 1std envelope
    figure(1)
    clf
    hold on;
    confplot(flipud(xm)-min(xm),T1Dmean,T1Dstd,T1Dstd,'LineWidth',3,'Color',[1 0 0]);
    hold on;
    xlabel('x distance (m)')
    ylabel('mean \it{T}')
    xlim([0 max(xm)-min(xm)])
    l=legend('mean $\textit{T} \pm 1\sigma$');
    set(l,'Interpreter','Latex');
    %t=title('wave period along y=950m transect');
    %set(t,'Interpreter','Latex');
    set (gca,'Xdir','reverse')
    shorestr = 'Shoreward';
    nshorestr = sprintf('Away from\nshore');
    text(0,3,nshorestr,'HorizontalAlignment','right');
    text(max(xm)-min(xm),3,shorestr,'HorizontalAlignment','left');
    plot(flipud(xm)-min(xm),ones(length(xm),1)*mean(T1Dmean),'k','Linewidth',1)
    print('figs/T1Dmean_std','-dpng')
end