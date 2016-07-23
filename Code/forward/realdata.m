%% Load real data for calculation 

% xmax
% Hmax
% Tb
% h

%% CALL-1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get Boundary Conditions (vector for a fixed time period, record hourly)
Hmax_vec = getBC('waveHs', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
  Tb_vec = getBC('wavePeakFrequency', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
  
% Choose one set of Hmax_vec & Tb_max (index must match)
Hmax = Hmax_vec(1);
  Tb = (Tb_vec(1))^(-1);

  
%% CALL-2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get bathymetry data
% [h,x] = get_hOct1
% This part is to get data from measurement points (depth_h & location_x)
% The data is needed for interpolation
[h,x] = get_hOct1;


%% CALL-3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Interpolation
% [hgrid, xq] = interp_h(h,x,dx)
% This part is to get the interpolated data (depth vector: hgrid & location vector: xp)

% grid size
dx = 25;

[hgrid, xq] = interp_h(h,x,dx);


%% Get the maximum x
xmax = max(xq);

%% Get the number of grid points
N1 = length(hgrid);


%% CALL-4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get wave number
k = wavenumber(Tb, hgrid);


%% Shallow water criterion
%% k*h << 1
kh = zeros(N1, 1);

for i = 1: N1
    kh(i) = k(i)*h(i);
end


%% CALL-5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get delta (rhs of the ODE)
delta = rhs_delta(hgrid, Tb, Hmax);


%% CALL-6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Get wave height from energy flux eqn by FDM
[H, n, cc, c_g, x] = waveheight(xmax, Hmax, hgrid, Tb, k, delta);


%% Energy
E = zeros(N1, 1);
for i = 1: N1
    E(i) = 1/8*1000*9.8*H(i)^2;
end


%% OUTPUT data to EXCEL
TIT = {'hgrid', ' ', 'wave height', ' ', 'wave number'};
xlswrite('Resuit for h&H&k', TIT);
xlswrite('Resuit for h&H&k', hgrid, 'sheet1', 'A2');
xlswrite('Resuit for h&H&k', H, 'sheet1', 'C2');
xlswrite('Resuit for h&H&k', k, 'sheet1', 'E2');



%% PLOT-1
%% (x & H) & (x & h) & (x & k)
figure;
plot(xq, H, '-*', xq, -hgrid, '-o', xq, k, '-^')
xlabel('x', 'FontSize', 18)
ylabel('H & h & k', 'FontSize', 18)
legend('Wave Height', 'Depth', 'Wave Number')
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-2
%% x & hgrid
figure;
plot(xq, -hgrid, 'linewidth', 3)
xlabel('x', 'FontSize', 18)
ylabel('depth', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-3
%% x & kh
figure;
plot(xq, kh, '-*')
xlabel('x', 'FontSize', 18)
ylabel('hk', 'FontSize', 18)
y1 = graph2d.constantline(1, 'Color',[1 0 0]);
changedependvar(y1,'y');
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-4
%% h & kh
figure;
plot(hgrid, kh, '-o')
xlabel('h', 'FontSize', 18)
ylabel('kh', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-5
%% h & E
figure;
plot(hgrid, E, '-^')
xlabel('h', 'FontSize', 18)
ylabel('Energy', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-6
%% x & E
figure;
plot(xq, E, '-*r')
xlabel('x', 'FontSize', 18)
ylabel('Energy', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-7
%% x & n
figure;
plot(x, n,'-*b')
xlabel('x', 'FontSize', 18)
ylabel('n', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-8
%% x & c
figure;
plot(x, cc,'-^g')
xlabel('x', 'FontSize', 18)
ylabel('wave phase speed (c)', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-9
%% x & c_g
figure;
plot(x, c_g,'-+k')
xlabel('x', 'FontSize', 18)
ylabel('wave breaking (\delta)', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-10
%% x & delta
figure;
plot(x, -delta,'-+b')
xlabel('x', 'FontSize', 18)
ylabel('wave breaking (\delta)', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-11
%% h & H
figure;
plot(hgrid,H)
xlabel('wave depth (h)', 'FontSize', 18)
ylabel('wave height (H)', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-12
%% h & k
figure;
plot(hgrid,k)
xlabel('wave depth (h)', 'FontSize', 18)
ylabel('wave number (k)', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-13
%% H & E
figure;
plot(H,E)
xlabel('wave height (h)', 'FontSize', 18)
ylabel('wave energy (E)', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)

%% PLOT-Last
%% (x & H) & (x & h)
figure;
subplot(2,1,1)
plot(xq,k,'-^');
xlabel('x', 'FontSize', 18);
ylabel('Wave Number', 'FontSize', 18)
str = sprintf('Hmax=%f, Tb=%f', Hmax, Tb);
title(str, 'FontSize', 20)
subplot(2,1,2)
plot(xq,H,'-*');
xlabel('x', 'FontSize', 18);
ylabel('Wave Height', 'FontSize', 18)