function [ erro ] = otimiza_PI( X )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global x t u num den

dt = 0.001;

%referência
wn = 10;
ksi = 0.8;

num = 2.514e-05;

den = -0.9975;

num_ref =  [2.514e-05   2.514e-05];
den_ref = [1 -0.9975];
x = X;
w=warning('off','all');
sim('planta',t);
warning(w);


%erro de ajuste
erro_quad = (y_ref - y_sys)'*(y_ref - y_sys);

%penalidade

satura = u.*(u > 4095);
penalidade = sum(satura);

erro = erro_quad + penalidade;
end

