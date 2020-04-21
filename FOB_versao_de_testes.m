
% Essa � uma vers�o para teste individual da FOB. Para isso os par�metros
% s�o setados e n�o recebidos como par�metro

clc; clear all;

% Essas linhas abaixo se referem ao c�lculo do valor literal de
% RespostaDegrau. Como � constante para esse sistema, optamos por jogar
% direto a express�o para poupar tempo de processamento

% syms Kp; syms Ki; syms Kd; syms Tf; syms s;
% b = 0.055;
% P = (1/(b*s+1))*(1/(0.125*s+1))
% C = Kp + Ki/s + Kd*s/(Tf*s+1)
% F = P*C/(1+P*C)
% RespostaDegrau = F/s
% Kp = 2; Ki = 3; Kd = 4; Tf = 5;
% RespostaDegrauNum = subs(RespostaDegrau)

syms Kp; syms Ki; syms Kd; syms Tf; syms s;
RespostaDegrau = (Kp + Ki/s + (Kd*s)/(Tf*s + 1))/(s*((Kp + Ki/s + (Kd*s)/(Tf*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1))
Kp = 2; Ki = 3; Kd = 4; Tf = 5;
RespostaDegrauNum = subs(RespostaDegrau)
% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrauNum,t))

% O erro � calculado como diferen�a entre o degrau de refer�ncia e a
% integrau da fun��o da resposta ao degrau. O erro � calculado do tempo t = 0 at� o tempo t = 0.1 

erro = double(0.1 - int(funcaoNoTempo,t,0,0.1))