
% Essa é uma versão para teste individual da FOB. Para isso os parâmetros
% são setados e não recebidos como parâmetro

clc; clear all; close all;

% Essas linhas abaixo se referem ao cálculo do valor literal de
% RespostaDegrau. Como é constante para esse sistema, optamos por jogar
% direto a expressão para poupar tempo de processamento

% syms Kp; syms Ki; syms Kd; syms Tf; syms s;
% b = 0.055;
% P = (1/(b*s+1))*(1/(0.125*s+1))
% C = Kp + Ki/s + Kd*s/(Tf*s+1)
% F = P*C/(1+P*C)
% RespostaDegrau = F/s
% Kp = 261.3; Ki = 6015; Kd = 2.691; Tf = 0.0004506;
% RespostaDegrauNum = subs(RespostaDegrau)

syms Kp; syms Ki; syms Kd; syms Tf; syms s;
RespostaDegrau = (Kp + Ki/s + (Kd*s)/(Tf*s + 1))/(s*((Kp + Ki/s + (Kd*s)/(Tf*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1))
Kp = 261.3; Ki = 6015; Kd = 2.691; Tf = 0.0004506;
RespostaDegrauNum = subs(RespostaDegrau)
% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrauNum,t))

% A seguir, serão calculados alguns parâmetros que podem servir de base
% para avaliação da resposta ao degrau

flagTs = 0; flagMp = 0; flagSt = 0;
funcaoNoTempoNumAnterior = 0;
j = 1;
for i=0.0001:0.0001:0.04
    funcaoNoTempoNum = subs(funcaoNoTempo,t,i);
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
    funcaoNoTempoVetor(10^4*i) = funcaoNoTempoNum;
end
figure
plot(funcaoNoTempoVetor)

erro = double(0.04 - int(funcaoNoTempo,t,0,0.04))*(1/Ts^2+1/(0.156*St)^2+(179*Mp)^2)/120000

% A funçao de erro acima foi definida levando em consideração tempo de
% subida (Ts), máximo sobressinal (Mp) e tempo de acomodação (St). 
% O erro é calculado como diferença entre o degrau de referência e a
% integrau da função da resposta ao degrau d tempo t = 0 até o tempo t = 0.04. 
% O fator multiplicador de penalidade é um multiplicador relacionado a Ts, Mp e St.
% Para parâmetros menores que 1(Ts e St), colocamos a multiplicador no denominador,
% para que, caso seja elevado, aumentem o erro. Já o Mp colocamos no
% multiplicador por ser positivo. Os parâmetros foram elevados ao quadrado
% para intensificar o processo de eliminação dos indivíduos com parâmetros
% muito diferentes do ideal. Além disso, as consantes que multiplicam os
% parâmetros servem para balancear igualmente os impactos dos 3 parâmetros
% na FOB. Mas para isso, é necessária uma referência. A referência
% escolhida foi baseada nos parâmetros Kp, Ki, Kd e Tf fornecidos pelo PID
% Tuner para a planta contínua P do código "Controle". As constantes foram
% escolhidas de modo que para esses Kp, Ki, Kd e Tf dados, os fatores
% 1/Ts^2, 1/(0.156*St)^2 e (179*Mp)^2 sejam cada um aproximadamente 40000. No
% fim, o erro é dividido novamente por 120000 para compensar 3*40000.
