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


