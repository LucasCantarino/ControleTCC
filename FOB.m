function [erro] = FOB(k)

syms s;
RespostaDegrau = (k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/(s*((k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1))

% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrau,t))

% A seguir, serão calculados alguns parâmetros que podem servir de base
% para avaliação da resposta ao degrau

flagTs = 0; flagMp = 0; flagSt = 0;
funcaoNoTempoNumAnterior = 0;
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
end
erro = double(0.04 - int(funcaoNoTempo,t,0,0.04) + exp(Ts-0.05) + exp(Mp-1.2) + exp(St-0.3))

%O erro é calculado como diferença entre o degrau de referência e a
% integral da função da resposta ao degrau d tempo t = 0 até o tempo t = 0.04.
% Poré, a função de erro acima foi definida levando em consideração tempo de
% subida (Ts), máximo sobressinal (Mp) e tempo de acomodação (St).  
% Para eliminar indivíduos com Ts, Mp e St altos, há os fatores exp(Ts-0.05), exp(Mp-1.2) exp(St-0.3)
% somando ao erro. Mas para isso, são necessárias referências. As
% referências escolhidas foram Ts = 0.05, Mp = 1.2 e St = 0.3 como sendo limites. Caso Ts, Mp ou St
% sejam iguais à referência limite o referente fator de soma será 1, e caso
% o limite seja ultrapassado, o fator de soma irá aumentar abruptamente.
