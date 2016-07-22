%==================================
% Purpose
% to find energy flux vector (?)
%===================================

%++++++++++++++++++++++++++++++++++++++++
% called from : bnathymetry
% call to: none
% =================================
%  INPUT
%  h: Depth
% Tb: Wave Period at boundary
% Hmax: maximum value of wave height
%==================================
%  OUTPUT
% delta: energy flux
%===============================
function[delta] = rhs_delta(h,Tb,Hmax)

rho = 1000; % water density
g = 9.8 ;% gravitational acceleration 

N1 = length(h);
delta = zeros(N1,1);
for i = 1: N1
     beta = 1;
        f = 1/Tb;
    H_rms = 2*sqrt(2)*Hmax;
      H_b = 0.78*h(i);        % This 0.78 is from breaking condition
        R = abs(H_b)/H_rms;
    
    delta(i) = 1/(4*h(i))*beta*rho*g*f*H_rms^3*((R^3+(3/2)*R)*exp(-R^2)+(3/4)*sqrt(pi)*(1-erf(R)));  % negative for dissipation
 
end
%delta