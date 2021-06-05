clc; clear all; close all;
tic;
% Os valores iniciais foram otidos usando PIDF com response time = 0.004915 e transient behaviour =
% 0.6 no código "controle" para a planta contínua P. Os valores máximos
% foram definidos no chute.

% As linhas abaixo são para otimizaçao com base em fmincon

% fun = @FOB;
% x0 = [261.2903,6015,3.6276,6.3695e-04];
% a = [];
% b = [];
% Aeq = [];
% Beq = [];
% lb = [100,2000,1.8,1e-4];
% ub = [400,8000,7,0.002];
% 
% k = fmincon(fun,x0,a,b,Aeq,Beq,lb,ub);

% Abaixo temos o melhor resultado encontrado através de fmincon

% Kp =
% 
%   261.2894
% 
% 
% Ki =
% 
%    6.0150e+03
% 
% 
% Kd =
% 
%     4.3721
% 
% 
% Tf =
% 
%    7.9539e-04
% 
%  
% esforcoControleNoTempoMax =
%  
% 5087.0585558824610788923410865623
%  
%  
% erroTotal =
%  
% 5.4030057772876995059020557413495
%  
% 
% erroPenalizado =
% 
%    5.4030


% As linhas abaixo são para otimização com base em ag caso não se opte pelo
% App de otimização

% nvars = 2;
% lb = [300,1700];
% ub = [400,1800];
% PopulationSize_Data = 10;
% EliteCount_Data = 5;
% MaxGenerations_Data = 1000;
% InitialPopulationMatrix_Data =                                                                       [353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766
%                                                                                                       353.5 1766];
%                                                                                                       %215.9 6968.5 2.500 0.00001
% 
% [k,fval,exitflag,output,population,score] = agConfig_malha_interna(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,MaxGenerations_Data,InitialPopulationMatrix_Data)

% Utilizando ag com as configurações acima, obtemos o resultados abaixo 
% (2 indivíduos)

% Kp =
% 
%   366.9678001403809
% 
% 
% Ki =
% 
%         1772.758792996407
% 
% Ts =
% 
%     0.0093
% 
%  
% Mp =
%  
% 1.0891936485323833888811676768411
%  
% 
% St =
% 
%     0.2230
% 
% erroTotal =
% 
%     26.8867
%  
% erroPenalizado =
% 
%    26.8867


% bat

% Max_iter=30;            % maximum generations
% N=10;                   %BAT numbers
% lb=[500,1000];
% ub=[800,14000];
% dim=2;
% [bestfit,BestPositions,fmin,Convergence_curve]=bat_malha_interna(N,Max_iter,lb,ub,dim)

% Resultados

% Kp = 805.6666228147072; Ki = 8288.368523310868;

% Ts =
% 
%     0.0202
% 
%  
% Mp =
%  
%   1.0569
%  
% 
% St =
% 
%     0.1100
% 
%  
% esforcoDeControleMax =
%  
% 
%  
% 
% erroTotal =
% 
%    11.4797
% 
% 
% erroPenalizado =
% 
%    11.4797

% GWO

SearchAgents_no = 10;
Max_iter = 150;
lb=[150,800,0,0];
ub=[700,20000,100,1];
dim = 4;
handles = 1;
Value = 1;
[Alpha_score,Alpha_pos,Convergence_curve]=GWO_malha_interna(SearchAgents_no,Max_iter,lb,ub,dim,handles,Value) 

% Kp =
%   345.9343997357137
% 
% 
% Ki =
% 
%    18500
% 
% 
% 
% Ts =
% 
%     0.0089
% 
% 
% Mp =
% 
%     1.3470
% 
% 
% St =
% 
%     0.0900
% 
% esforcoDeControleMax =
% 
%   349.6035
% 
% erroTotal =
% 
%    22.7034
% 
% 
% erroPenalizado =
% 
%    22.7212

tempoEmMinutos = toc/60 