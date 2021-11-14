%Par�metros bons:
% 
% x =
% 
%   800.3937  301.9090   49.6914    0.0000


clc
close all
clear all

dt = 0.001;

global num den y_ref y_sys

num = [1.104392655054829e-08 3.313177965164485e-08 3.313177965164485e-08 1.104392655054829e-08];

den = [1 - 2.981694681338594 2.963566104560976 -0.981871423222382];

%ganhos iniciais
global x;
% x(1) = 18.16; %Kp
% x(2) = 0; %Ki
% x(3) = 2; %Kd
% x(4) = 1262;% Filtro
x(1) = 0; %Kp
x(2) = 0; %Ki
x(3) = 0; %Kd
x(4) = 0;% Filtro

global t;
t = 0:dt:1;


sim('malha_fechada_planta',t);

% y_ref = ans.y_ref;
% y_sys = ans.y_sys;

plot(t,y_ref)
hold on
plot(t,y_sys) 

options = optimset('Algorithm','interior-point', ...
                    'Display','on','TolX',1e-8);

%kp_max = 100.46; %kp_max = u_max/e_max; u_max = 4095; e_max = maximo do motor - zero
% x = fmincon(@otimiza_PIDF_completa,x,[],[],[],[],[800 0 0 0],[inf 250 1000 inf],@QQQ,options);
x = fmincon(@otimiza_PIDF_completa,x,[],[],[],[],[800 0 0 0],[inf inf inf inf],@QQQ,options);


sim('malha_fechada_planta',t);

% y_ref = ans.y_ref;
% y_sys = ans.y_sys;

figure

plot(t,y_ref)
hold on
plot(t,y_sys)

% tranf_aux = tf([1 0],[x(4) 1]);
transf_aux = tf([1, -1],[1, -(2*x(4)-dt)/(2*x(4)+dt)],dt)
x
% tranf_aux_d = c2d(tranf_aux,0.001,'tustin')