function [erroPenalizado] = FOB(k)
syms s;
% Descomentar abaixo para testes
% k(1) = 261.3; k(2) = 6015; k(3) = 2.691; k(4) = 0.0004506;
RespostaDegrau = (k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/(s*((k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1));
esforcoControle = (k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/(s*((k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1));

% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrau,t));
esforcoControleNoTempo = vpa(ilaplace(esforcoControle,t));
% A seguir, ser�o calculados alguns par�metros que podem servir de base
% para avalia��o da resposta ao degrau

flag =0;
funcaoNoTempoNumAnterior = 0;
Kp = k(1)
Ki = k(2)
Kd = k(3)
Tf = k(4)
St = 10;
for i=0.001:0.0001:0.04
    funcaoNoTempoNum = subs(funcaoNoTempo,i);
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
end
esforcoControleNoTempoMax = real(subs(esforcoControleNoTempo,0.0001))
if(flag == 0)
    for i=0.001:0.0001:0.04
        if funcaoNoTempoNum>=0.98
            St = i;
            break
        end
    end
    erro = double(0.04 - int(funcaoNoTempo,t,0,0.04) + 3*exp(St-0.3) + exp(esforcoControleNoTempoMax-5122))
end
if(flag == 1)
    erro=10
end
if(flag == 2)
    erro = double(0.04 - int(funcaoNoTempo,t,0,0.04) + exp(Ts-0.05) + exp(Mp-1.2) + exp(St-0.3) + exp(esforcoControleNoTempoMax-5122))
end
erroReal = real(double(0.04 - int(funcaoNoTempo,t,0,0.04)))
erroPenalizado = real(erro);
%O erro � calculado como diferen�a entre o degrau de refer�ncia e a
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