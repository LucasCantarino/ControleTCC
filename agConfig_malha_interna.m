function [x,fval,exitflag,output,population,score] = agConfig_malha_interna(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,MaxGenerations_Data,InitialPopulationMatrix_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'PopulationSize', PopulationSize_Data);
options = optimoptions(options,'EliteCount', EliteCount_Data);
options = optimoptions(options,'MaxGenerations', MaxGenerations_Data);
options = optimoptions(options,'InitialPopulationMatrix', InitialPopulationMatrix_Data);
options = optimoptions(options,'Display', 'off');
[x,fval,exitflag,output,population,score] = ...
ga(@FOB_malha_interna,nvars,[],[],[],[],lb,ub,[],options);