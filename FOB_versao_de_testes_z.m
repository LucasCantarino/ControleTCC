clc; clear all; close all;
% Essa � uma vers�o para teste individual da FOB. Para isso os par�metros
% s�o setados e n�o recebidos como par�metro

%clc; clear all; close all;

% Essas linhas abaixo se referem ao c�lculo do valor literal de
% RespostaDegrau. Como � constante para esse sistema, optamos por jogar
% direto a express�o para poupar tempo de processamento

syms Kp; syms Ki; syms Kd; syms Tf; syms z;
Ts = 0.0002;
b = 0.055;
Pd = (1.452*10^(-6)*z^2 + 2.904*10^(-6)*z + 1.452*10^(-6))/(z^2 - 1.996*z + 0.9964)
C = Kp + Ki*Ts/(z-1) + Kd/(Tf + Ts/(z-1))

% Para o c�lculo de F, foram usados dois m�todos no c�digo "Controle.m"

%F =feedback(Pd*C,1)
%F = (0.007483*z^4 + 0.0001401*z^3 - 0.01483*z^2 - 0.0001388*z + 0.007344)/(1.007*z^4 - 3.633*z^3 + 4.885*z^2 - 2.902*z + 0.6416)
%F = Pd*C/(1+Pd*C)
F = (0.007483*z^8 - 0.02705*z^7 + 0.02133*z^6 + 0.0327*z^5 - 0.06046*z^4 + 0.01575*z^3 + 0.02699*z^2  - 0.0214*z + 0.004658)/(1.007*z^8 - 7.293*z^7 + 23.02*z^6 - 41.37*z^5 + 46.3*z^4 - 33.03*z^3 + 14.66*z^2 - 3.702*z + 0.407)

RespostaDegrau = F*z/(z-1)
%RespostaDegrau = F*((0.0005*z + 0.0005)/(z-1));
esforcoControle = RespostaDegrau/Pd
Kp = 262.2; Ki = 6024; Kd = 2.692; Tf = 0.0005503;
RespostaDegrauNum = subs(RespostaDegrau)
esforcoControleNum = subs(esforcoControle)

% syms Kp; syms Ki; syms Kd; syms Tf; syms z;
% Ts = 0.0002;
% RespostaDegrau = (z*((1714219033281681*z^2)/1180591620717411303424 + (1714219033281681*z)/590295810358705651712 + 1714219033281681/1180591620717411303424)*(Kp + Kd/(Tf + 1/(5000*(z - 1))) + Ki/(5000*(z - 1))))/(((((1714219033281681*z^2)/1180591620717411303424 + (1714219033281681*z)/590295810358705651712 + 1714219033281681/1180591620717411303424)*(Kp + Kd/(Tf + 1/(5000*(z - 1))) + Ki/(5000*(z - 1))))/(z^2 - (499*z)/250 + 2491/2500) + 1)*(z - 1)*(z^2 - (499*z)/250 + 2491/2500))
% esforcoControle = (z*(Kp + Kd/(Tf + 1/(5000*(z - 1))) + Ki/(5000*(z - 1))))/(((((1714219033281681*z^2)/1180591620717411303424 + (1714219033281681*z)/590295810358705651712 + 1714219033281681/1180591620717411303424)*(Kp + Kd/(Tf + 1/(5000*(z - 1))) + Ki/(5000*(z - 1))))/(z^2 - (499*z)/250 + 2491/2500) + 1)*(z - 1))
% Kp = 261.3; Ki = 6015; Kd = 2.691; Tf = 0.0004506;
% RespostaDegrauNum = subs(RespostaDegrau)
% esforcoControleNum = subs(esforcoControle)
% Calculando a inversa de laplace

funcaoNoTempo = vpa(iztrans(RespostaDegrauNum))
esforcoControleNoTempo = vpa(iztrans(esforcoControleNum))
% A seguir, ser�o calculados alguns par�metros que podem servir de base
% para avalia��o da resposta ao degrau

flag = 0;
funcaoNoTempoNumAnterior = 0;
j = 1;
for i=0.001:0.001:0.04
    funcaoNoTempoNum = subs(funcaoNoTempo,i);
    esforcoControleNoTempoNum = subs(esforcoControleNoTempo,i);
    if (flag == 0 && funcaoNoTempoNum>=1)   % Tempo de subida
        Ts = i
        flag = 1;
    end
    if (flag == 1 && funcaoNoTempoNum<funcaoNoTempoNumAnterior) % M�ximo sobressinal
        Mp = real(funcaoNoTempoNumAnterior)
        flag = 2;
    end
    if (flag == 2 && funcaoNoTempoNum<=1.02) % Tempo de acomoda��o
        St = i
        break
    end
    funcaoNoTempoNumAnterior = funcaoNoTempoNum; 
    funcaoNoTempoVetor(j) = funcaoNoTempoNum;
    EsforcoControleNoTempoVetor(j) = esforcoControleNoTempoNum;
    vetorTempo(j) = i;
    j = j + 1;
end
figure
plot(vetorTempo,funcaoNoTempoVetor)
figure
plot(vetorTempo,EsforcoControleNoTempoVetor)

esforcoDeControleMax = EsforcoControleNoTempoVetor(1)
% Caso o sistema controlado possa ser superamortecido, descomentar as
% linhas abaixo

if(flag == 0)
    St = 10;
    for i=0.001:0.0002:0.04
        if funcaoNoTempoNum>=0.98
            St = i
            break
        end
    end 
    erroPenalizado = double(0.04 - 0.0002*sum(funcaoNoTempoVetor) + 3*exp(St-0.3)) + exp(esforcoDeControleMax-5122)
end
if(flag == 1)
    erroPenalizado=10
end
if(flag == 2) 
    erroPenalizado = double(0.04 - 0.0002*sum(funcaoNoTempoVetor) + exp(Ts-0.05) + exp(Mp-1.2) + exp(St-0.3)) + exp(esforcoDeControleMax-5122)
end
erroReal = double(0.04 - 0.0002*sum(funcaoNoTempoVetor))
% O erro � calculado como diferen�a entre o degrau de refer�ncia e a
% integral da fun��o da resposta ao degrau d tempo t = 0 at� o tempo t = 0.04.
% Por�, a fun��o de erro acima foi definida levando em considera��o tempo de
% subida (Ts), m�ximo sobressinal (Mp) e tempo de acomoda��o (St).  
% Para eliminar indiv�duos com Ts, Mp e St altos, h� os fatores exp(Ts-0.05), exp(Mp-1.2) exp(St-0.3)
% somando ao erro. Mas para isso, s�o necess�rias refer�ncias. As
% refer�ncias escolhidas foram Ts = 0.05, Mp = 1.2 e St = 0.3 como sendo limites. Caso Ts, Mp ou St
% sejam iguais � refer�ncia limite o referente fator de soma ser� 1, e caso
% o limite seja ultrapassado, o fator de soma ir� aumentar abruptamente.

% Obs: caso o sistema seja superamortecido, Mp � 0 e St n�o se aplica. Al�m
% disso, o termo exp(St-0.3) � multiplicado por 3 para evitar selecionar
% sistemas superamortecidos lentos.