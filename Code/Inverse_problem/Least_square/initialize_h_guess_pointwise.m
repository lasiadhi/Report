function [h_guess] = initialize_h_guess_pointwise(hgrid, xgrid, dx)
% This function creats an initial guess for the depths over the discrete
% grid. It currently just guesses a linear profile from the beach to
% boundary condition.

n = length(xgrid);

k = find(~hgrid, 1);

xi = xgrid(k);

    slope = -11/xi;
    h_guess = zeros(n, 1);
    h_guess(1) = hgrid(1);

    for i = 2:k
        h_guess(i) = h_guess(i-1) + slope*dx;
    end 
    for i = k+1:n
        h_guess(i) = 0;
    end 
end 