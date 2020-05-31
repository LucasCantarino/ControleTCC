clc; clear all; close all;
tic;
% Os valores iniciais foram otidos usando PIDF com response time = 0.004915 e transient behaviour =
% 0.6 no código "controle" para a planta contínua P. Os valores máximos
% foram definidos no chute.

% A linha abaixo é para otimizaçao com base em fmincon

% k = fmincon(@FOB,[261.2903,6015,3.6276,6.3695e-04],[],[],[],[],[100,2000,1.8,1e-4],[400,8000,7,0.002]);

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

% nvars = 4;
% lb = [100,2000,1.8,1e-4];
% ub = [400,8000,7,0.002];
% PopulationSize_Data = 10;
% EliteCount_Data = 5;
% MaxGenerations_Data = 10;
% InitialPopulationMatrix_Data =                                                                       [261.2903 6015 3.6276 6.3695e-04;
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
% [k,fval,exitflag,output,population,score] = agConfig(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,MaxGenerations_Data,InitialPopulationMatrix_Data)
                                                                                                   
% Utilizando ag com as configurações acima, obtemos o resultados abaixo 
% (2 indivíduos)

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

Max_iter=10;            % maximum generations
N=10;                   %BAT numbers
lb=[100,2000,1.8,1e-4];
ub=[400,8000,7,0.002];
dim=4;
[bestfit,BestPositions,fmin,Convergence_curve]=bat(N,Max_iter,lb,ub,dim)

% Resultado

% Kp = 143.2133; Ki = 3286.5; Kd = 3.7841; Tf = 0.0011;

% Ts =
% 
%     0.0039
% 
%  
% Mp =
%  
% 1.10168588562028395761850848855
%  
% 
% St =
% 
%     0.0101
% 
%  
% esforcoDeControleMax =
%  
% 3275.8897673825109275800557401289
%  
% 
% erroPenalizado =
% 
%     2.6105
% 
% 
% erroReal =
% 
%    8.9235e-04

% GWO

% SearchAgents_no = 10;
% Max_iter = 30;
% lb = [100,2000,1.8,1e-4];
% ub = [400,8000,7,0.002];
% dim = 4;
% handles = 1;
% Value = 1;
% [Alpha_score,Alpha_pos,Convergence_curve]=GWO(SearchAgents_no,Max_iter,lb,ub,dim,handles,Value) 

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


% Kp = 168.9052; Ki = 3049.6; Kd = 3.6692; Tf = 0.00064447;
% 
% Ts =
% 
%     0.0043
% 
%  
% Mp =
%  
% 1.0418212865610254353993013997555
%  
% 
% St =
% 
%     0.0369
%     
% esforcoDeControleMax =
%  
% 5021.6939034490385246040955027914 - 5.4435683199949144890848676810367e-34i
%  
% 
% erroPenalizado =
% 
%    2.5785
% 
% 
% erroReal =
% 
%    8.0822e-04

tempoEmMinutos = toc/60 