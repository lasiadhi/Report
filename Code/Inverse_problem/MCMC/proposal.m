function [hprop,kprop] = proposal(depthmean_prior,depthstd_prior)
%{
A proposed vector of h to compare
%}

    % Propose h
    hprop = normrnd(depthmean_prior,depthstd_prior);
    %Get proposed k | h
    [kprop, ~] = forward(hprop);


end