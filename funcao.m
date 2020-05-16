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

% [x,fval,exitflag,output,population,score] = agConfig(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,MaxGenerations_Data,InitialPopulationMatrix_Data)
[k,fval,exitflag,output,population,score] = agConfig(4,[130,3000,1.8,3e-4],[500,12000,7,0.0015],10,5,10,[261.2903 6015 3.6276 6.3695e-04; 
                                                                                                         260.2899 6015 3.6115 6.3273e-04; 
                                                                                                         261.2841 6015 3.6703 6.4511e-04;
                                                                                                         261.2841 6015 3.6703 6.4509e-04;
                                                                                                         261.2867 6015 3.6775 6.4650e-04; 
                                                                                                         261.2867 6015 3.6775 6.4649e-04;
                                                                                                         260.9981 6015 2.0893 3.0174e-04;
                                                                                                         261.2879 6015 3.6842 6.4796e-04;
                                                                                                         261.2879 6015 3.6842 6.4774e-04;
                                                                                                         261.2879 6015 3.6842 6.4794e-04])
% Utilizando ag com as configurações acima, obtemos o resultado abaixo
% como sendo o ótimo

% Kp =
% 
%   260.2899
% 
% 
% Ki =
% 
%         6015
% 
% 
% Kd =
% 
%     3.6703
% 
% 
% Tf =
% 
%    6.4509e-04
% 
% 
% Ts =
% 
%     0.0038
% 
%  
% Mp =
%  
% 1.0809187082335011689711732370578
%  
% 
% St =
% 
%     0.0341
% 
%  
% esforcoControleNoTempoMax =
%  
% 5110.1566242441081663149689396619
%  
% 
% erroReal =
% 
%    2.6265e-04
