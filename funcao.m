clc; clear all; close all;

% Os valores iniciais foram otidos usando PIDF com response time = 0.004915 e transient behaviour =
% 0.6 no código "controle" para a planta contínua P. Os valores máximos
% foram definidos no chute.

% A linha abaixo é para otimizaçao com base em fmincon

k = fmincon(@FOB,[261.2903,6015,3.6276,6.3695e-04],[],[],[],[],[130,3000,1.8,3e-4],[500,12000,7,0.0015]);

% Abaixo temos o melhor resultado encontrado através de fmincon

% Kp =
% 
%   261.2903
% 
% 
% Ki =
% 
%    6.0150e+03
% 
% 
% Kd =
% 
%     3.6276
% 
% 
% Tf =
% 
%    6.3695e-04
% 
% 
% Ts =
% 
%     0.0039
% 
%  
% Mp =
%  
% 1.0813778434162163505916093783053
%  
% 
% St =
% 
%     0.0340
% 
%  
% esforcoControleNoTempoMax =
%  
% 5106.2981337423424129458159427797
%  
% 
% erroReal =
% 
%    2.5670e-04

% As linhas abaixo são para otimização com base em ag caso não se opte pelo
% App de otimização

% fun = @FOB;
% [k,fval] = ga(fun,4,[],[],[],[],[26,600,0.27,0.000045],[1000,50000,20,0.01])

% Utilizando ag com as configurações mostradas nos prints e com o indivíduo
% inicial [261.2875,6015,3.6076,6.3273e-04], obtemos o resultado abaixo
% como sendo o ótimo

% Kp =
% 
%   260.2899
% 
% 
% Ki =
% 
%    6.0150e+03
% 
% 
% Kd =
% 
%     3.6115
% 
% 
% Tf =
% 
%    6.3273e-04
% 
% 
% Ts =
% 
%     0.0039
% 
%  
% Mp =
%  
% 1.0809892041848846340681988981329
%  
% 
% St =
% 
%     0.0341
% 
%  
% esforcoControleNoTempoMax =
%  
% 5110.8840911410805812012360958546
%  
% 
% erroReal =
% 
%    2.5549e-04