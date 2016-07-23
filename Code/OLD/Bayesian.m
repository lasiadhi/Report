%{
This is for one estimate of Wave Height. Still not sure about if it runs
correctly with the missing variables.
%}



%{
f-wave freq.,h-depth, H-wave height, T-period, Hrms-root mean sq. wave 
height, Hb-wave height breaking point, Hmo-boumdary condition for wave
height
%}


B = 1;
g = 9.8;
rho = 0.4 ;
T= 8;
f = 1/T;
h= 15;
Hmo= 13;
Hrms = (2*sqrt(2)*Hmo);
Hb = 0.78*h;
R = Hb/Hrms;


delta = @(h)((1/(4*h))*B*rho*g*f*(Hrms^3)*((((R^3)+ 3*R/2)*(exp(-R^2)))+(3*sqrt(pi)/4)*(1-erf(R))));


%this practice to check delta was working fplot('delta', [0, 100]);


%Bayesian Pt 1
H =3;

prior = @(H)(2*H/Hrms)*exp(-((H/Hrms)^2)); %H = need wave heights for prior distribution

marginal = @(H)integral(delta,0,inf);

%Can't multiply 2 functions in line below without calling the function but
%these are two different variables so I am unsure. I looked it up, every
%one that I saw used only one variable

WaveH = ((delta*prior)/marginal); %conditional pdf of H given h

%Bayesian Pt 2 Estimation of height (this should probably be a function)

NewWaveH = WaveH*(integral(H*delta,0,inf)); % Wave Height Estimate given a depth 

NewWaveH


