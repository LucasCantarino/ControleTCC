clc
close all
clear all

dt = 0.001;

%referÍncia
wn = 10;
ksi = 0.8;

global num den

num = 2.514e-05;

den = -0.9975;

num_ref = [wn^2];
den_ref = [1 2*wn*ksi wn^2];

%ganhos iniciais
global x;
x(1) = 353.5;
x(2) = 1766;

global t;
t = 0:dt:1;


sim('planta',t);

plot(t,y_ref)
hold on
plot(t,y_sys)

options = optimset('Algorithm','interior-point', ...
                    'Display','on','TolX',1e-7);

%kp_max = 100.46; %kp_max = u_max/e_max; u_max = 4095; e_max = maximo do motor - zero
x = fmincon(@otimiza_PI,x,[],[],[],[],[0 0],[inf inf],@QQQ,options);


sim('planta',t);

figure 

%y_ref = 10*ones(size(y_sys));

plot(t,y_ref)
hold on
plot(t,y_sys)

y_dir = y_sys;

% Direito:
% 
% [Kp Ki] = [409.5 1766.8]

num = 2.868e-05;

den = -0.995;

x = fmincon(@otimiza_Esq,x,[],[],[],[],[0 0],[inf inf],@QQQ,options);

plot(t,y_sys)

% Direito:
% 
% [Kp Ki] = [409.5 1766.8]

% Esquerdo:
% 
% [Kp Ki] = [346.7 2619.0]
