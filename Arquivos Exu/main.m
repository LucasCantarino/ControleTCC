clc
close all
clear all

dt = 0.001;

num_l = 0;
den_l = 0;

num_r = 0;
den_r = 0;

x_r = [0 0];
x_l = [0 0];

%referência
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

L = 0.1; %diâmetro do robô

sim('planta',t);

plot(t,y_ref)
hold on
plot(t,y_sys)

options = optimset('Algorithm','interior-point', ...
                    'Display','on','TolX',1e-7);

%kp_max = 100.46; %kp_max = u_max/e_max; u_max = 4095; e_max = maximo do motor - zero
x = fmincon(@otimiza_PI,x,[],[],[],[],[0 0],[inf inf],@QQQ,options);

%configuração dos parâmetros da malha externa (malha do motor direito)

num_r = num;
den_r = den;

x_r(1) = x(1);
x_r(2) = x(2);


sim('planta',t);

figure 

y_ref = 10*ones(size(y_sys));

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

%configuração dos parâmetros da malha externa (malha do motor esquerdo)

num_l = num;
den_l = den;

x_l(1) = x(1);
x_l(2) = x(2);

plot(t,y_sys)

% Direito:
% 
% [Kp Ki] = [409.5 1766.8]

% Esquerdo:
% 
% [Kp Ki] = [346.7 2619.0]

%wn = wd*wn*sqrt(1-zeta)
