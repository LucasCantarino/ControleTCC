function [c,ceq] = nonlcon(k)
syms s;

esforcoControle = (k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/(s*((k(1) + k(2)/s + (k(3)*s)/(k(4)*s + 1))/((s/8 + 1)*((11*s)/200 + 1)) + 1));

% Calculando a inversa de laplace

syms t;
esforcoControleNoTempo = vpa(ilaplace(esforcoControle,t));

% A seguir, serão calculados alguns parâmetros que podem servir de base
% para avaliação da resposta ao degrau
EsforcoMax = real(subs(esforcoControleNoTempo,0.0001))
c = EsforcoMax;
ceq = [];