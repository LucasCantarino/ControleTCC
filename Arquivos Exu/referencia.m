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

Gd = c2d(G,dt,'tustin')

