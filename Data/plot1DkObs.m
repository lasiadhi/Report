function plot1DkObs
%{
Plot mean and standard deviation of k along y=950m transect
 
USAGE:
plot1DkObs
%}
    %get the x values
    %filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/BathyDuck-ocean_bathy_argus_201510.nc';
    filename = 'http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/BathyDuck-ocean_bathy_argus_201510.nc';
    xm = ncread(filename,'xm');
    
    % get mean and variance of 1D k values over time
    [k1Dmean,k1Dstd,x_k]=get1DkStats();
    
    % access matlab functions below
    addpath('mfunc/confplot')
    
    %plot mean with +/- 1std envelope
    figure(1)
    clf
    hold on;
    confplot(x_k,k1Dmean,k1Dstd,k1Dstd,'LineWidth',3,'Color',[1 0 0]);
    xlabel('x distance (m)')
    ylabel('mean \it{k}')
    xlim([min(x_k) max(x_k)])
    l=legend('mean $\textit{k} \pm 1\sigma$');
    set(l,'Interpreter','Latex');
    %t=title('wave number along y=950m transect');
    %set(t,'Interpreter','Latex');
    set (gca,'Xdir','reverse')
    shorestr = 'Shoreward';
    nshorestr = sprintf('Away from\nshore');
    text(min(x_k),0.025,nshorestr,'HorizontalAlignment','right');
    text(max(x_k),0.025,shorestr,'HorizontalAlignment','left');
    print('figs/k1Dmean_std','-dpng')
end