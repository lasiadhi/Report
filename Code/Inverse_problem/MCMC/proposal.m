
function [hprop,kprop] = proposal(h)
%{
A proposed vector of h to compare
%}

    % Propose h

    h_inc = 0.5+randn(length(h),1); %tune 0.5 here
    hprop = h+h_inc;

    %Propose a spatially correlated h 
%     dstd=depthstd_prior(1);
%     std_samp = normrnd(0,dstd);
%     hprop = depthmean_prior + std_samp;
% 


%     %Quasi correlated: every pt much be within 1 m of the point next to it
%     hprop = normrnd(depthmean_prior,depthstd_prior);
%     for i = 1:length(hprop) - 1
%         if abs(hprop(i) - hprop(i+1)) > 1
%             hprop(i) = depthmean_prior(i) + std_samp;
%         else
%             hprop(i) = hprop(i);
%         end
%     end

    %Get proposed k | h
    [kprop, ~] = forward(hprop);


end