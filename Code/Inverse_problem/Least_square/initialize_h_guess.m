function [h_guess] = initialize_h_guess(xgrid,dx)
% This function creats an initial guess for the depths over the discrete
% grid. It currently just guesses a linear profile from the beach to
% boundary condition.
    
    slope = -11/1150;
    h_guess = zeros(size(xgrid));
    h_guess(1) = 11;
    
    for i = 2:size(xgrid)
        h_guess(i) = h_guess(i-1) + slope*dx;
    end 
end 