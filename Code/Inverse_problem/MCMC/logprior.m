function [prior,fudgestd] = logprior(h,bath)
%{
Need a prior on what we want: depth, h
Get this from previous observations. Use this to build a prior distribution
on h
%}
<<<<<<< HEAD
xvec=(0:25:1150);
depth = bath.depth;
=======


>>>>>>> 6cc1b8dd0429d740d9277095c093bb92c66cf4c0

%Assume depth distribution is normal and find mean/std at each x
depth = bath.depth;
depthmean = nanmean(depth,2); %mean over time dimension
depthstd = std(depth,0,2);

<<<<<<< HEAD
=======
xvec=(1:10:1150);
>>>>>>> 6cc1b8dd0429d740d9277095c093bb92c66cf4c0
depthmeanInterp = interp1(depthmean,xvec);
fudgestd = 0.5;


<<<<<<< HEAD
prior = log(normpdf(h,flip(depthmean),depthstd));
%prior = log(normpdf(h,depthmeanInterp',depthstd));
%prior = log(normpdf(h,0,depthstd));
=======
<<<<<<< HEAD

%prior = log(normpdf(h,depthmeanInterp',fudgestd));
prior = log(normpdf(h,0,fudgestd));
=======
prior = log(normpdf(h,depthmean,depthstd));
%prior = log(normpdf(h,depthmeanInterp',depthstd));
%prior = log(normpdf(h,0,fudgestd));
>>>>>>> 6cc1b8dd0429d740d9277095c093bb92c66cf4c0
>>>>>>> 3bd56bad1598ba90603c0e12aa598d6332d782d7

end