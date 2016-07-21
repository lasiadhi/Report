function plot1DkObs
%{
Plot mean and standard deviation of k along y=950m transect
%}
    %get the x values
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';
    xm = ncread(filename,'xm');
    
    % get mean and variance of 1D k values over time
    [k1Dmean,k1Dstd]=get1DkStats(k1D);
    
    %plot mean with +/- 1std envelope
    figure
    clf
    hold on;
    confplot(flipud(xm)-min(xm),k1Dmean,k1Dstd,k1Dstd,'LineWidth',3,'Color',[1 0 0]);
    xlabel('x distance (m)')
    ylabel('mean \it{k}')
    xlim([0 max(xm)-min(xm)])
    l=legend('mean $\textit{k} \pm 1\sigma$');
    set(l,'Interpreter','Latex');
    t=title('\textit{k} along y=950m transect');
    set(t,'Interpreter','Latex');
    set (gca,'Xdir','reverse')
end