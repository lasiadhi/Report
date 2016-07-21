function [k1Dmean,k1Dstd]=get1DkStats()
%{
Calculate mean and variance over time for 1D transect of k values.

USAGE:
[k1Dmean,k1Dstd]=get1DkStats()
%}
    k1D=get1Dk();
    
    k1Dmean = nanmean(k1D,2); %mean over time dimension
    k1Dstd = nanstd(k1D,1,2); %variance over time dimension with weight=1

end