clc;
clear all
close all

wn = 30;
ksi = 1;
G = tf(wn^2,[1,2*wn*ksi,wn^2]);

dt = 0.001;

t = 0:dt:1;

u = ones(size(t))*0.3;

y = lsim(G,u,t);

plot(t,y)

hold on

Gd = c2d(G,dt,'tustin')
x1 = [19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03];
x2 = [19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03];
x3 = [19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03];
x4 = [19.084590462235568,0.834556138365885,2.934654194649224,1.261980419886278e+03];

x = x1;

sim('TesteMalhaExterna_referenciaR2018b',t);
y_sys = ans.y_sys;
plot(t,y_sys)

x = x2;

figure

sim('TesteMalhaExterna_referenciaR2018b',t);
y_sys = ans.y_sys;
plot(t,y_sys)

x = x3;

figure

sim('TesteMalhaExterna_referenciaR2018b',t);
y_sys = ans.y_sys;
plot(t,y_sys)

x = x4;

figure

sim('TesteMalhaExterna_referenciaR2018b',t);
y_sys = ans.y_sys;
plot(t,y_sys)


