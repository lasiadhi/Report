function k = kBC
%This function gets the wave number at the boundary conditions for the
%forward 1D model over its initial and end times
f = mean(getBC('wavePeakFrequency','2015-10-01 00:00:02', '2015-10-31 23:00:03'));
k = 4*(pi^2)/(9.8*(1/f)^2);
end