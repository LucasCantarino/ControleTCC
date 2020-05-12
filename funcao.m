clc; clear all; close all;

% Os valores iniciais foram otidos usando PIDF com response time = 0.004915 e transient behaviour =
% 0.6 no código "controle" para a planta contínua P. Os valores máximos
% foram definidos no chute.

% A linha abaixo é para otimizaçao com base em fmincon

% k = fmincon(@FOB,[261.3,6015,2.691,0.0004506],[],[],[],[],[26,600,0.27,0.000045],[1000,50000,20,0.01]);

% As linhas abaixo são para otimização com base em ag caso não se opte pelo
% App de otimização

fun = @FOB;
[k,fval] = ga(fun,4,[],[],[],[],[26,600,0.27,0.000045],[1000,50000,20,0.01])

