xmax = 1150;
Hmax = 1;

h = [11; 10; 9.5; 8.5; 7.5; 2.6; 6; 4; 3.2; 2.6; 2; 1.4; 0.8; 0.3; 0.1];


%====================================
for im=1:5
    Tb(im)=20*im;
g = 9.8;        % m/s2
rho = 1000;     % kg/m3

% to get the value of number of subinterval
[N1 ,N2] = size(h);

% N number of subinterval
N = N1-1;

% Boundary Condition
H    = zeros(N1, 1);
H(1) = Hmax;
%H(N1) = Hmax;

% mesh size
xmin = 0;
dx   = (xmax - xmin)/N;

% x vector for plot
x    = zeros(N1, 1);
x(1) = xmin;
for i = 2: N1
    x(i) = x(1) + (i-1)*dx;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computing Wave Number from the dispersion relation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% af: angular fruquency
% af^2 = g*k*tanh(k*h)
af = 2*pi/Tb(im);

% Initial vector of wave number
k = zeros(N1, 1);
iter = 20;
kk = zeros(N1, 1);
for i = 1: N1
    for j=1: iter
        kk(1) = 1;
        kk(j+1) = kk(j) - (g*kk(j)*tanh(kk(j)*h(i))-af^2)/(g*tanh(kk(j)*h(i))+g*h(i)*kk(j)*(sech(kk(j)*h(i)))^2);
    end
    k(i) = kk(iter);
end

% initialize of matrix A 
A = zeros(N1);

% Constant
lambda = rho*g*pi/(8*Tb(im));

% Coefficient
c = zeros(N1, 1);

for i = 1: N1
    c(i) = (1+(2*k(i)*h(i))/sinh(2*k(i)*h(i)))*lambda/(k(i)*dx);
end

for i = 1: N1-1
    A(i, i)   = c(i);
    A(i+1, i) = -c(i);
end
A(N1, N1) = c(N1);


% A*H = delta
delta   = ones(N1,1); % right hand side vector

A(1,1)  = 1;
delta(1)= H(1)^2;

% Solve for y (y = H^2)
y = A\delta;
H = sqrt(y);

% Wave Height Limit (H<Hmax)
H1    = zeros(N1, 1);
H1(1) = H(1);
for i = 2: N1
    H1(i) = (delta(i)*dx+c(i)*(H1(i-1))^2)/c(i);
    H1(i) = sqrt(H1(i));
    Hmax  = 0.78*h(i);
    H(i)  = min(H1(i),Hmax);
end

% figure;
% plot(x, H, '-*', x, -h, '-o', x, k, '-^')
% xlabel('x')
% ylabel('H & h & k')
% %title({['Tb = ', num2str(Tb(im))]})
% legend('Wave Height', 'Depth', 'Wave Number')
% hold on

subplot(2,1,1)
plot(x, k, '-^');
xlabel('x');
ylabel('Wave Number')
%legend({['Tb = ', num2str(Tb(im))]})
legend('Tb = 20','Tb = 40','Tb = 60','Tb = 80','Tb = 100')
hold on

subplot(2,1,2)
plot(x,H,'-*');
xlabel('x');
ylabel('Wave Height')
hold on

end%this is the closing end for Tb