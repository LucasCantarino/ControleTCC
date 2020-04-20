clc; clear all; close all;

% Os valores iniciais foram otidos usando PIDF com response time = 0.004915 e transient behaviour =
% 0.6 no código "controle" para a planta contínua P. Os valores máximos
% foram definidos no chute.
k = fmincon(@FOB,[261.3,6015,2691,0.0004506],[],[],[],[],[0,0,0,0],[1000,50000,10000,0.01]);

