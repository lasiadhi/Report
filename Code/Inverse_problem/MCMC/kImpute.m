function kImputed = kImpute(x_k,kdat,nh)
%{
Function to impute missing values of k along the profile of h we're
interested in estimating (from 0 offshore to 1150m at the shore)
%}
    
    
    %linear regression of k to be extrapolated along profile of h
    mdl = fitlm(x_k,kdat);
    int = mdl.Coefficients.Estimate(1);
    slope = mdl.Coefficients.Estimate(2);

    %initialize k,x,and j
    j=1;
    x=[0:10:1140]';
    kImputed=nan(nh,1);
    for i = 1:nh
        %keep k where it exists
        if j < length(x_k) && x_k(j) == x(i)
            kImputed(i,1) = kdat(j);
            j=j+1;
        %fill in k where it doesn't exist
        else
            kImputed(i,1) = slope*x(i) + int;  
        end
    end

end
