function [ erro_quad ] = otimiza_PIDF( X )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global x t num den y_ref y_sys

num = [1.104392655054829e-08 3.313177965164485e-08 3.313177965164485e-08 1.104392655054829e-08];

den = [1 - 2.981694681338594 2.963566104560976 -0.981871423222382];
x = X;
w=warning('off','all');
sim('TesteMalhaExternaR2018b',t);

y_ref = ans.y_ref;
y_sys = ans.y_sys;

warning(w);

%erro de ajuste
% erro_quad = (y_ref - y_sys)'*(y_ref - y_sys);
% erro_quad = (y_ref(round(3*end/4:end)) - y_sys(round(3*end/4:end)))'*(y_ref(round(3*end/4:end)) - y_sys(round(3*end/4:end)));
erro_quad = sum(abs(y_ref(round(9*end/10:end)) - y_sys(round(9*end/10:end))));
end
