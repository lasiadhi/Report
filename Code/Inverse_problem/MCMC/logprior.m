function [prior,fudgestd] = logprior(h,bath)
%{
Need a prior on what we want: depth, h
Get this from previous observations. Use this to build a prior distribution
on h
%}
xvec=(0:25:1150);
depth = bath.depth;

%Assume depth distribution is normal and find mean/std at each x
depthmean = nanmean(depth,2); %mean over time dimension
depthstd = std(depth,0,2);

depthmeanInterp = interp1(depthmean,xvec);
fudgestd = 0.5;



%prior = log(normpdf(h,depthmeanInterp',fudgestd));
prior = log(normpdf(h,0,fudgestd));

end