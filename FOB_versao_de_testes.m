
% Essa é uma versão para teste individual da FOB. Para isso os parâmetros
% são setados e não recebidos como parâmetro

clc; clear all; close all;

% Essas linhas abaixo se referem ao cálculo do valor literal de
% RespostaDegrau. Como é constante para esse sistema, optamos por jogar
% direto a expressão para poupar tempo de processamento

% syms Kp; syms Ki; syms Kd; syms Tf; 
syms s;
% b = 0.055;
% P = (1/(b*s+1))*(1/(0.125*s+1))
% C = Kp + Ki/s + Kd*s/(Tf*s+1)
% F = P*C/(1+P*C)
% RespostaDegrau = F/s
% esforcoControle = RespostaDegrau/P
% Kp = 261.3; Ki = 6015; Kd = 2.691; Tf = 0.0004506;
% RespostaDegrauNum = subs(RespostaDegrau)

syms Kp; syms Ki; syms Kd; syms Tf; syms s;
RespostaDegrau = (Kp + Ki/s + (Kd*s)/(Tf*s + 1))/(s*((Kp + Ki/s + (Kd*s)/(Tf*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1))
esforcoControle = (Kp + Ki/s + (Kd*s)/(Tf*s + 1))/(s*((Kp + Ki/s + (Kd*s)/(Tf*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1))
Kp = 261.3; Ki = 6015; Kd = 2.691; Tf = 0.0004506;
RespostaDegrauNum = subs(RespostaDegrau)
esforcoControleNum = subs(esforcoControle)
% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrauNum,t))
esforcoControleNoTempo = vpa(ilaplace(esforcoControleNum,t))
% A seguir, serão calculados alguns parâmetros que podem servir de base
% para avaliação da resposta ao degrau

flag = 0;
funcaoNoTempoNumAnterior = 0;
j = 1;
for i=0.0001:0.0001:0.04
    funcaoNoTempoNum = subs(funcaoNoTempo,t,i);
    esforcoControleNoTempoNum = subs(esforcoControleNoTempo,t,i);
    if (flag == 0 && funcaoNoTempoNum>=1)   % Tempo de subida
        Ts = i
        flag = 1;
    end
    if (flag == 1 && funcaoNoTempoNum<funcaoNoTempoNumAnterior) % Máximo sobressinal
        Mp = double(funcaoNoTempoNumAnterior)
        flagMp = 1;
        flag = 2;
    end
    if (flag == 2 && funcaoNoTempoNum<=1.02) % Tempo de acomodação
        St = i
        break
    end
    funcaoNoTempoNumAnterior = funcaoNoTempoNum; 
    j = j + 1;
    funcaoNoTempoVetor(j) = funcaoNoTempoNum;
    EsforcoControleNoTempoVetor(j) = esforcoControleNoTempoNum;
    vetorTempo(j) = i;
end
figure
plot(vetorTempo,funcaoNoTempoVetor)
figure
plot(vetorTempo,EsforcoControleNoTempoVetor)

esforcoDeControleMax = max(esforcoControleNoTempoNum)
% Caso o sistema controlado possa ser superamortecido, descomentar as
% linhas abaixo

if(flag == 0)
    for i=0.001:0.0001:0.04
        if funcaoNoTempoNum>=0.98
            St = i;
            break
        end
    end 
    erro = double(0.04 - int(funcaoNoTempo,t,0,0.04) + 3*exp(St-0.3));
end
if(flag == 1 || esforcoDeControleMax > 5122)
    erro=10;
end
if(flag == 2) 
    erro = double(0.04 - int(funcaoNoTempo,t,0,0.04)+ exp(Ts-0.05) + exp(Mp-1.2) + exp(St-0.3));
end
esforcoDeControleMax



%O erro é calculado como diferença entre o degrau de referência e a
% integral da função da resposta ao degrau d tempo t = 0 até o tempo t = 0.04.
% Poré, a função de erro acima foi definida levando em consideração tempo de
% subida (Ts), máximo sobressinal (Mp) e tempo de acomodação (St).  
% Para eliminar indivíduos com Ts, Mp e St altos, há os fatores exp(Ts-0.05), exp(Mp-1.2) exp(St-0.3)
% somando ao erro. Mas para isso, são necessárias referências. As
% referências escolhidas foram Ts = 0.05, Mp = 1.2 e St = 0.3 como sendo limites. Caso Ts, Mp ou St
% sejam iguais à referência limite o referente fator de soma será 1, e caso
% o limite seja ultrapassado, o fator de soma irá aumentar abruptamente.

% Obs: caso o sistema seja superamortecido, Mp é 0 e St não se aplica. Além
% disso, o termo exp(St-0.3) é multiplicado por 3 para evitar selecionar
% sistemas superamortecidos lentos.


