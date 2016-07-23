function [T1Dmean,T1Dstd]=get1DTStats()
%{
Calculate mean and variance over time for 1D transect of k values.

USAGE:
[k1Dmean,k1Dstd]=get1DkStats()
%}
    T1D=get1DT();
    
    T1Dmean = nanmean(T1D,2); %mean over time dimension
    T1Dstd = nanstd(T1D,1,2); %variance over time dimension with weight=1

end