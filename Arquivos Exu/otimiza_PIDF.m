function [ erro_quad ] = otimiza_PIDF( X )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global x t num den

num = [1.104392655054829e-08 3.313177965164485e-08 3.313177965164485e-08 1.104392655054829e-08];

den = [1 - 2.981694681338594 2.963566104560976 -0.981871423222382];
x = X;
w=warning('off','all');
sim('TesteMalhaExterna',t);
warning(w);

%erro de ajuste
erro_quad = (ans.y_ref - ans.y_sys)'*(ans.y_ref - ans.y_sys);

end
