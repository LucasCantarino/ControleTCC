function [c,ceq] = restri(k)
syms s;
RespostaDegrau = (k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/(s*((k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1)*(s/8 + 1)*((11*s)/200 + 1));

esforcoControle = (k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/(s*((k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1));

% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrau,t));
esforcoControleNoTempo = vpa(ilaplace(esforcoControle,t));

% A seguir, serão calculados alguns parâmetros que podem servir de base
% para avaliação da resposta ao degrau
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
        Ts = i;
        flag = 1;
    end
    if (flag == 1 && funcaoNoTempoNum<funcaoNoTempoNumAnterior) % Máximo sobressinal
        Mp = real(funcaoNoTempoNumAnterior)
        flag = 2;
    end
    if (flag == 2 && funcaoNoTempoNum<=1.02) % Tempo de acomodação
        St = i;
        break
    end
    funcaoNoTempoNumAnterior = funcaoNoTempoNum;    
end
if(flag == 0)
    for i=0.001:0.0001:0.04
        if funcaoNoTempoNum>=0.98
            St = i;
            break
        end
    end
end
EsforcoMax = real(subs(esforcoControleNoTempo,0.0001))
c(1) = Ts - 0.05;
c(2) = Mp - 1.2;
c(3) = St - 0.3;
c(4) = EsforcoMax - 5122;
ceq = [];