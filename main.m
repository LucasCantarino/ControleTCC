clc; clear all; close all;
tic;
% Os valores iniciais foram otidos usando PIDF com response time = 0.004915 e transient behaviour =
% 0.6 no c�digo "controle" para a planta cont�nua P. Os valores m�ximos
% foram definidos no chute.

% A linha abaixo � para otimiza�ao com base em fmincon

%k = fmincon(@FOB,[261.2903,6015,3.6276,6.3695e-04],[],[],[],[],[130,3000,1.8,3e-4],[500,12000,7,0.0015]);

% Abaixo temos o melhor resultado encontrado atrav�s de fmincon

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

% As linhas abaixo s�o para otimiza��o com base em ag caso n�o se opte pelo
% App de otimiza��o

% nvars = 4;
% lb = [130,3000,1.8,3e-4];
% ub = [500,12000,7,0.0015];
% PopulationSize_Data = 10;
% EliteCount_Data = 5;
% MaxGenerations_Data = 10;
% InitialPopulationMatrix_Data = [261.2903 6015 3.6276 6.3695e-04;
%                                                                                                       261.2903 6015 3.6294 6.3695e-04;
%                                                                                                       261.2841 6015 3.6703 6.4511e-04;
%                                                                                                       261.2841 6015 3.6703 6.4509e-04;
%                                                                                                       261.2867 6015 3.6775 6.4650e-04; 
%                                                                                                       261.2867 6015 3.6775 6.4649e-04;
%                                                                                                       260.9981 6015 2.0893 3.0174e-04;
%                                                                                                       261.2879 6015 3.6842 6.4796e-04;
%                                                                                                       261.2879 6015 3.6842 6.4774e-04;
%                                                                                                       261.2879 6015 3.6842 6.4794e-04];
%                                                                                                       %215.9 6968.5 2.500 0.00001
% 
% [x,fval,exitflag,output,population,score] = agConfig(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,MaxGenerations_Data,InitialPopulationMatrix_Data)
                                                                                                   
% Utilizando ag com as configura��es acima, obtemos o resultados abaixo 
% (2 indiv�duos)

% Kp =
% 
%   261.2867
% 
% 
% Ki =
% 
%         6016
% 
% 
% Kd =
% 
%     3.3776
% 
% 
% Tf =
% 
%    6.3695e-04
% 
% 
% Ts =
% 
%     0.0041
% 
%  
% Mp =
%  
% 1.0891936485323833888811676768411
%  
% 
% St =
% 
%     0.0338
% 
% 
% erroReal =
% 
%    2.2574e-04
% 
% 
% Kp =
% 
%   261.2867
% 
% 
% Ki =
% 
%    6.0155e+03
% 
% 
% Kd =
% 
%     3.3776
% 
% 
% Tf =
% 
%    6.3695e-04
% 
% 
% Ts =
% 
%     0.0041
% 
%  
% Mp =
%  
% 1.0891926386568503894636653283185
%  
% 
% St =
% 
%     0.0338
% 
% 
% erroReal =
% 
%    2.2579e-04





% Kp =
% 
%   260.9981
% 
% 
% Ki =
% 
%         6015
% 
% Kd =
% 
%     2.0893
% 
% 
% Tf =
% 
%    6.4649e-04
% 
% 
                                                                                                            
% Ts =
% 
%     0.0053
% 
%  
% Mp =
%  
% 1.1788495873827175211029444306311
%  
% 
% St =
% 
%     0.0284
% 
%  
% esforcoDeControleMax =
%  
% 3022.1470381715193508726783923556
%  
% 
% 
% erroReal =
% 
%    6.4218e-05

% bat

% Max_iter=10;            % maximum generations
% N=10;                   %BAT numbers
% lb=[130,3000,1.8,3e-4];
% ub=[500,12000,7,0.0015];
% dim=4;
% [bestfit,BestPositions,fmin,Convergence_curve]=bat(N,Max_iter,lb,ub,dim)

% GWO

SearchAgents_no = 10;
Max_iter = 20;
lb = [130,3000,1.8,3e-4];
ub = [500,12000,7,0.0015];
dim = 4;
handles = 1;
Value = 1;
[Alpha_score,Alpha_pos,Convergence_curve]=GWO(SearchAgents_no,Max_iter,lb,ub,dim,handles,Value) 

% Resultado

% Kp = 137.8763; Ki = 3237.9; Kd = 4.0726; Tf = 0.00072595;

% Ts =
% 
%     0.0039
% 
%  
% Mp =
%  
% 1.0414522806710464051090834029733
%  
% 
% St =
% 
%     0.0080
% 
%  
% esforcoDeControleMax =
%  
% 5004.361054775815223294892741739
%  
% 
% erroPenalizado =
% 
%     2.5561
% 
% 
% erroReal =
% 
%    9.5975e-04

tempoEmMinutos = toc/60 