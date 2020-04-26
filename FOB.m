function [erro] = FOB(k)

syms s;
RespostaDegrau = (k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/(s*((k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1))

% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrau,t))

% A seguir, ser�o calculados alguns par�metros que podem servir de base
% para avalia��o da resposta ao degrau

flagTs = 0; flagMp = 0; flagSt = 0;
funcaoNoTempoNumAnterior = 0;
for i=0.0001:0.0001:0.04
    funcaoNoTempoNum = subs(funcaoNoTempo,t,i)
    if (flagTs == 0 && funcaoNoTempoNum>=1)   % Tempo de subida
        Ts = i
        flagTs = 1;
    end
    if (flagMp == 0 && funcaoNoTempoNum<funcaoNoTempoNumAnterior) % M�ximo sobressinal
        Mp = funcaoNoTempoNumAnterior
        flagMp = 1;
        flagSt = 1;
    end
    if (flagSt == 1 && funcaoNoTempoNum<=1.02) % Tempo de acomoda��o
        St = i
        break
    end
    funcaoNoTempoNumAnterior = funcaoNoTempoNum;
end

% O erro � calculado como diferen�a entre o degrau de refer�ncia e a
% integrau da fun��o da resposta ao degrau. O erro � calculado do tempo t = 0 at� o tempo t = 0.04 

erro = double(0.04 - int(funcaoNoTempo,t,0,0.04))*(1/Ts^2+1/(0.156*St)^2+(179*Mp)^2)/120000

% A fun�ao de erro acima foi definida levando em considera��o tempo de
% subida (Ts), m�ximo sobressinal (Mp) e tempo de acomoda��o (St). 
% O erro � calculado como diferen�a entre o degrau de refer�ncia e a
% integrau da fun��o da resposta ao degrau d tempo t = 0 at� o tempo t = 0.04. 
% O fator multiplicador de penalidade � um multiplicador relacionado a Ts, Mp e St.
% Para par�metros menores que 1(Ts e St), colocamos a multiplicador no denominador,
% para que, caso seja elevado, aumentem o erro. J� o Mp colocamos no
% multiplicador por ser positivo. Os par�metros foram elevados ao quadrado
% para intensificar o processo de elimina��o dos indiv�duos com par�metros
% muito diferentes do ideal. Al�m disso, as consantes que multiplicam os
% par�metros servem para balancear igualmente os impactos dos 3 par�metros
% na FOB. Mas para isso, � necess�ria uma refer�ncia. A refer�ncia
% escolhida foi baseada nos par�metros Kp, Ki, Kd e Tf fornecidos pelo PID
% Tuner para a planta cont�nua P do c�digo "Controle". As constantes foram
% escolhidas de modo que para esses Kp, Ki, Kd e Tf dados, os fatores
% 1/Ts^2, 1/(0.156*St)^2 e (179*Mp)^2 sejam cada um aproximadamente 40000. No
% fim, o erro � dividido novamente por 120000 para compensar 3*40000.
