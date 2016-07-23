function [prior,depthmean,depthstd] = logprior(h,bath)
%{
Need a prior on what we want: depth, h
Get this from previous observations. Use this to build a prior distribution
on h
%}

depth = bath.depth;

%Assume depth distribution is normal and find mean/std at each x
depthmean = nanmean(depth,2); %mean over time dimension
depthstd = std(depth,0,2);

prior = log(normpdf(h,depthmean,depthstd));

end