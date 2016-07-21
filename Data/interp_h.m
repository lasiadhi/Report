function [hgrid,xq] = interp_h(h,x,dx)
% This function turns the h values taken from the transect of interest into
% gridded values for (0 >= x >= 1150 m).
%
%-------------------------------------------------------------------------
% Usage Statement
% [hgrid, xq] = interp_h(h,x,5)       
% (calls for 5 m resolution)
%-------------------------------------------------------------------------

    num_pnts = 1150/dx-1;
    xq(1) = dx;
    
    for i=2:num_pnts
        xq(i) = xq(i-1)+dx;
    end
    
    % use spline interpolate the points with-in the domain of the
    % original h.
    % pchip has be used instead of spline because pchip is shape
    % preserving.
    hgrid = interp1(x,h,xq,'pchip',NaN);
    
    
    NaNcheck = isnan(hgrid);
    ii = find(NaNcheck == 0);
    
    % slope for linear interpolation further off shore
    slope = -(11-hgrid(min(ii)))/(xq(min(ii)));
    hgrid(1) = 11 + slope*dx;
    
    % fill points between survey data and BC
    for i = 2:min(ii)-1
        hgrid(i) = hgrid(i-1) + slope*dx;
    end
    
    % fill points on "beach"
    for i = max(ii)+1:length(xq)
        hgrid(i) = 0;
    end
    
end