function [ erro_quad ] = otimiza_PIDF( X )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global x t num den y_ref y_sys

num = [1.104392655054829e-08 3.313177965164485e-08 3.313177965164485e-08 1.104392655054829e-08];

den = [1 - 2.981694681338594 2.963566104560976 -0.981871423222382];
x = X;
w=warning('off','all');
sim('TesteMalhaExterna_referenciaR2018b',t);

y_ref = ans.y_ref;
y_sys = ans.y_sys;

warning(w);

%erro de ajuste
% erro_quad = (y_ref - y_sys)'*(y_ref - y_sys);
erro_quad = (y_ref(round(3*end/4:end)) - y_sys(round(3*end/4:end)))'*(y_ref(round(3*end/4:end)) - y_sys(round(3*end/4:end)));
% erro_quad = sum(abs(y_ref - y_sys)); % x1 = [19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03]
% erro_quad = sum(abs(y_ref(round(3*end/4:end)) - y_sys(round(3*end/4:end)))); x2 = %[19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03]
% erro_quad = sum(abs(y_ref(round(2*end/4:end)) - y_sys(round(2*end/4:end)))); %x3 = [19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03]
% erro_quad = sum(abs(y_ref(round(1*end/4:end)) - y_sys(round(1*end/4:end)))); %x4 = [19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03]
end
