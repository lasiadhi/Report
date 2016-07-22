function [Hmean,Hstd,Tmean,Tstd]=getplotBCStats()
%{ 
Calculate simple statistics in time on various variables at the boundary condition

USAGE:
[Hmean,Hstd,Tmean,Tstd]=getplotBCStats()

OUTPUT:
Hmean is the mean wave height during October 2015 at the boundary condition
point
Hstd is the standard deviation
figs/waveHeight_BC1D_Stats.png is the histogram of wave height
Tmean is the mean wave period
Tstd is the standard deviation
figs/wavePeriod_BC1D_Stats.png is the histogram of wave period 

%}  
    %stats on wave height during October 2015
    H = getBC('waveHs');
    Hmean = nanmean(H); %mean over time dimension
    Hstd = nanstd(H); %std over time
    
    figure(1)
    clf
    hst=histogram(H); hold on
    hst.BinWidth = 0.25;
    yl=ylim;
    HmeanLine = ones(yl(2)+1,1)*Hmean;
    plot(HmeanLine,0:yl(2),'b','Linewidth',3)
    meanlabel='\textbf{Mean \textit{H}}';
    la=text(Hmean*1.05,yl(2)*0.75,meanlabel,'HorizontalAlignment','left','Color','b');
    t=title('Wave height during October 2015');
    x=xlabel('wave height, \textit{H} (m)');
    y=ylabel('N')    ;
    set(la,'Interpreter','Latex');
    set(t,'Interpreter','Latex');
    set(x,'Interpreter','Latex');
    set(y,'Interpreter','Latex');
    print('figs/waveHeight_BC1D_Stats','-dpng')
    
    %get wave peak frequency (and therefore period) during all of October
    fp = getBC('wavePeakFrequency');
    %transform frequency intp period
    T = 1./fp;
    %stats on wave period during October 2015
    Tmean = nanmean(T); %mean over time dimension
    Tstd = nanstd(T); %std over time
    
    figure(2)
    clf
    hst=histogram(T);hold on
    hst.BinWidth = 1;
    hst.FaceColor = 'r';
    yl=ylim;
    TmeanLine = ones(yl(2)+1,1)*Tmean;
    plot(TmeanLine,0:yl(2),'Color',[0.9 0.1 0.15],'Linewidth',3)
    la=text(Tmean*.97,yl(2)*0.75,'\textbf{Mean \textit{T}=\n}','HorizontalAlignment','right','Color',[0.9 0.1 0.15]);
    t=title('Wave period during October 2015');
    x=xlabel('wave period, \textit{T} (s)');
    y=ylabel('N');
    set(la,'Interpreter','Latex');
    set(t,'Interpreter','Latex');
    set(x,'Interpreter','Latex');
    set(y,'Interpreter','Latex');
    print('figs/wavePeriod_BC1D_Stats','-dpng')
    
    
    
    
    

end