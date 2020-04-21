
% Essa é uma versão para teste individual da FOB. Para isso os parâmetros
% são setados e não recebidos como parâmetro

clc; clear all;

% Essas linhas abaixo se referem ao cálculo do valor literal de
% RespostaDegrau. Como é constante para esse sistema, optamos por jogar
% direto a expressão para poupar tempo de processamento

% syms Kp; syms Ki; syms Kd; syms Tf; syms s;
% b = 0.055;
% P = (1/(b*s+1))*(1/(0.125*s+1))
% C = Kp + Ki/s + Kd*s/(Tf*s+1)
% F = P*C/(1+P*C)
% RespostaDegrau = F/s
% Kp = 261.3; Ki = 6015; Kd = 2691; Tf = 0.0004506;
% RespostaDegrauNum = subs(RespostaDegrau)

syms Kp; syms Ki; syms Kd; syms Tf; syms s;
RespostaDegrau = (Kp + Ki/s + (Kd*s)/(Tf*s + 1))/(s*((Kp + Ki/s + (Kd*s)/(Tf*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1))
Kp = 261.3; Ki = 6015; Kd = 2691; Tf = 0.0004506;
RespostaDegrauNum = subs(RespostaDegrau)
% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrauNum,t))

% A seguir, serão calculados alguns parâmetros que podem servir de base
% para avaliação da resposta ao degrau

flagTs = 0; flagMp = 0; flagSt = 0;
funcaoNoTempoNumAnterior = 0;
for i=0.0001:0.000001:0.001
    funcaoNoTempoNum = subs(funcaoNoTempo,t,i)
    if (flagTs == 0 && funcaoNoTempoNum>=1)   % Tempo de subida
        Ts = i
        flagTs = 1;
    end
    if (flagMp == 0 && funcaoNoTempoNum<funcaoNoTempoNumAnterior) % Máximo sobressinal
        Mp = funcaoNoTempoNumAnterior
        flagMp = 1;
        flagSt = 1;
    end
    if (flagSt == 1 && funcaoNoTempoNum<=1.02) % Tempo de acomodação
        St = i
        break
    end
    funcaoNoTempoNumAnterior = funcaoNoTempoNum;
end
% O erro é calculado como diferença entre o degrau de referência e a
% integrau da função da resposta ao degrau. O erro é calculado do tempo t = 0 até o tempo t = 0.1 

erro = double(0.1 - int(funcaoNoTempo,t,0,0.1))