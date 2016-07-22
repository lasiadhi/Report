% get BC (vector for a fixed period)

Hmax_vec = getBC('waveHs', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
  Tb_vec = getBC('wavePeakFrequency', '2015-10-01 00:00:00', '2015-10-02 00:00:00');
  
% Choose one set of Hmax_vec & Tb_max (index must match)
Hmax = Hmax_vec(1);
  Tb1 = Tb_vec(1);
  Tb=1/Tb1;

% [h,x] = get_hOct1

[h,x] = get_hOct1;

% interp_h(h,x,dx)

dx = 10;

[hgrid, xq] = interp_h(h,x,dx);

% Initial vector of wave number
k = zeros(N1, 1);iter=70;af=(2*pi)/Tb;
for i=1:N1
    h1=hgrid(i);
k_in=0.2;
k_old=k_in;
for j=1:iter
    k_new=k_old-((g*k_old)*tanh(k_old*h1)-af^2)/(g*tanh(k_old*h1)+g*h1*k_old*(sech(k_old*h1))^2);
    k_old=k_new;
end
 k(i)=k_old;
end

%========================================================


delta = rhs_delta(hgrid,Tb,Hmax);

[H, x, n, c, c_g, E] = waveheight_test(xmax, Hmax, hgrid, Tb, k, delta);

% shallow water 
kh = zeros(N1, 1);

for i = 1: N1
    kh(i) = k(i)*h(i);
end

%H = bathymetry(xmax, Hmax, h, Tb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of H, h, k vs x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(x, H, '-*', x, -hgrid, '-o', x, k, '-^')
xlabel('x')
ylabel('H & h & k')
legend('Wave Height(H)', 'Depth(h)', 'Wave Number(k)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot for hk vs x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(x, kh,'-or')
xlabel('x')
ylabel('hk')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of n vs x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(x, n,'-*b')
xlabel('x')
ylabel('n')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of c vs x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(x, c,'-^g')
xlabel('x')
ylabel('wave phase speed (c)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of c_g vs x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(x, c_g,'-+k')
xlabel('x')
ylabel('group speed (c_g)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of delta vs x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(x, -delta,'-+b')
xlabel('x')
ylabel('wave breaking (\delta)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of energy(E) vs x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(x, E,'-*r')
xlabel('x')
ylabel('wave energy (E)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of H vs h
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
%plot(h, H,'*r')
scatter(hgrid,H)
xlabel('wave depth (h)')
ylabel('wave height (H)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of h vs k
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
scatter(hgrid,k,'b')
xlabel('wave depth (h)')
ylabel('wave number (k)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of h vs E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
scatter(hgrid,E,'k')
xlabel('wave depth (h)')
ylabel('wave energy (E)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot of H vs E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
scatter(H,E,'g')
xlabel('wave height (H)')
ylabel('wave energy (E)')


figure;
subplot(2,1,1)
plot(x,k,'-^');
xlabel('x');
ylabel('Wave Number(k)')
subplot(2,1,2)
plot(x,H,'-*');
xlabel('x');
ylabel('Wave Height(H)')