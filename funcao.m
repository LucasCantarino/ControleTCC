clc; clear all; close all;

% Os valores iniciais foram otidos usando PIDF com response time = 0.004915 e transient behaviour =
% 0.6 no c�digo "controle" para a planta cont�nua P. Os valores m�ximos
% foram definidos no chute.

% A linha abaixo � para otimiza�ao com base em fmincon

% k = fmincon(@FOB,[261.3,6015,2.691,0.0004506],[],[],[],[],[26,600,0.27,0.000045],[1000,50000,20,0.01]);

% As linhas abaixo s�o para otimiza��o com base em ag caso n�o se opte pelo
% App de otimiza��o

fun = @FOB;
[k,fval] = ga(fun,4,[],[],[],[],[26,600,0.27,0.000045],[1000,50000,20,0.01])

