function [ delta1 ] = delta( h,Tb,Hmax )
%==================================================
%         DESCRIPTION
% This function will providde the vector for delta,
% where delta=d/dx(E C_g) is from energy flux method.
% E:energy
% C_g: group celerity
%==================================================
%         INPUT
% h: depth
% Tb: period
% Hmax: maxmimum value of wave height
%==================================================
%        OUTPUT
% delta
% NOTE: delta will have the same size as depth h.
%==================================================

beta=1;
f=1/Tb;               % frequency
H_rms=2*sqrt(2)*Hmax; % root mean square of wave height
H_b=0.78.*h;          % This 0.78 is from breaking condition
R=abs(H_b)/H_rms; 
rho=1000;             % water density
g=9.8;                % gravitational acceleration

N=length(h);
delta1=zeros(N,1);
delta1(1:N)=1./(4.*h(1:N)).*beta.*rho.*g.*f.*H_rms^3.*((R(1:N).^3+(3/2).*R(1:N)).*exp(-R(1:N).^2)+(3/4)*sqrt(pi).*(1-erf(R(1:N))));

end

