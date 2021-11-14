%Gera a planta a ser utilizada no arquivo simulink "MalhaExternaSimplificadaR2018b"
%Planta obtida através do gráfico de resposta ao degrau gerado pela arquivo
%simulink "planta.slx"

clear all; close all; clc;

% tp = 0.235;
ts = 0.481;
% tr = 0.138;
pico = 0.952;%valor de pico
est = 0.9048;% valor de estado estacionario
tx_sobresinal = (pico-est)/est % equação da pagina 100 da apostila de lab de controle
max_out = est;
max_in = 1.81;

k_planta = max_out/max_in;

% wd = pi/tp; % Equação 5.20 do ogata

zeta = sqrt(1/(1+(pi/log(tx_sobresinal))^2))

% wn = (wd/sqrt(1 - zeta^2)) % Equação mostrada no exemplo 5.1 do ogata

wn = 4/(zeta*ts)
wn = wn*1.1;

sys = tf([0 0 wn^2*k_planta],[1 2*zeta*wn wn^2])
% Função de Transferência encontrada:
%          89.16
%   --------------------
%   s^2 + 18.3 s + 178.4

% step(sys);
% 11.52*2*pi*0.1*0.25*step(sys);
% t = 0:1:138;
% plot(t,ans)
% grid on

t = 0:0.001:10;

sys_stp = lsim(sys,1.81*ones(length(t),1),t);
plot(t,sys_stp)
hold on
grid on

stp = 1.81*ones(10001,1);
plot(t,stp)

%Planta de posição (integração da planta de velocidade angular)
sys_pos = tf([0 0 wn^2*k_planta],[1 2*zeta*wn wn^2])*tf([0 1],[1 0])
% Função de Transferência encontrada:
%            89.16
%   ------------------------
%   s^3 + 18.3 s^2 + 178.4 s

% Discretização:
sys_pos_d = c2d(sys_pos,0.001,'tustin')
% Função de Transferência encontrada:
%   1.104392655054829e-08 z^3 + 3.313177965164485e-08 z^2 + 3.313177965164485e-08 z + 1.104392655054829e-08
%   -------------------------------------------------------
%             z^3 - 2.981694681338594 z^2 + 2.963566104560976 z -0.981871423222382







