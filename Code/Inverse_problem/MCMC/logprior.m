function [prior,fudgestd] = logprior(h,bath)
%{
Need a prior on what we want: depth, h
Get this from previous observations. Use this to build a prior distribution
on h
%}



%Assume depth distribution is normal and find mean/std at each x
depth = bath.depth;
depthmean = nanmean(depth,2); %mean over time dimension
depthstd = std(depth,0,2);

xvec=(1:10:1150);
depthmeanInterp = interp1(depthmean,xvec);
fudgestd = 0.5;


prior = log(normpdf(h,depthmean,depthstd));
%prior = log(normpdf(h,depthmeanInterp',depthstd));
%prior = log(normpdf(h,0,fudgestd));

end