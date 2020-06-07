clc; close all; clear all;

dt = 0.001;
t = 0:dt:1.4;
u = 1000*ones(size(t));

%esquerdo
a1 = 0.01167;
b1 = 0.2;

%direito
a2 = 0.01021;
b2 = 0.2;

%continuo
G_L = tf(a1,[b1 1]);
G_R = tf(a2,[b2 1]);

%discreto
G_Ld = c2d(G_L,dt,'tustin');
G_Rd = c2d(G_R,dt,'tustin');

vL = lsim(G_Ld,u,t);
vR = lsim(G_Rd,u,t);
figure;
plot(t,vL)
hold on
plot(t,vR)

%controlador para degrau maximo de 1,152 (pwm de 355) e response time 0.111
KpL = 308.2;
KiL = 1540;

KpR = 353.5;
KiR = 1766;

PID_L = KpL*tf(1,1) + KiL*tf(1,[1 0]);
PID_R = KpR*tf(1,1) + KiR*tf(1,[1 0]);

PID_Ld = c2d(PID_L,dt,'tustin');
PID_Rd = c2d(PID_R,dt,'tustin');

MalhaInternaLd = feedback(PID_Ld*G_Ld,1);
MalhaInternaRd = feedback(PID_Rd*G_Rd,1);

t = 0:dt:0.4;
u = ones(size(t));
vL_pid = lsim(MalhaInternaLd,0.001*u,t);
vR_pid = lsim(MalhaInternaRd,0.001*u,t);

figure
plot(t,vL_pid,'bo')
hold on
plot(t,vR_pid,'ro')

% Aceleração
% a(1) = 0; 
% for i=2:length(t)
%     a(i) = (vR_pid(i)-vR_pid(i-1))/0.0002;
% end
% figure
% plot(t,18*a)

b = 0.055;
P = tf(1,[b 1])*tf(1,[0.125 0])
Pd = c2d(P,dt,'tustin')

% Utilizar PIDF com response time = 0.004915 e transient behaviour =
% 0.6 (esforço máximo de 5122)

C = 178.7389 + tf(2666.5,[1,0]) + tf([5.2654,0],[0.0012,1])
Cd = c2d(C,dt,'tustin')
Gd = feedback(Cd*Pd,1)

degrauContinuo = tf(1,[1 0]);
degrauDiscreto = c2d(degrauContinuo,dt,'tustin')
respostaDegrau = Gd*degrauDiscreto
esforcoControle = respostaDegrau/Pd
[num,den] = tfdata(esforcoControle);
[r,p,k] = residue(num{1,1},den{1,1})
for i = 1:7
    fracoesParciais(i) = tf([r(i) 0],[1 -p(i)],dt);
    [num(i),den(i)] = tfdata(fracoesParciais(i));
end
fracoesParciais(i+1) = k;
fracoesParciais
syms n;
for i = 1:7
    a = -den{1,i}(1,2);
    K = num{1,i}(1);
    for n = 1:20 %(0.001s a 0.02s)
        esforcoControleNoTempo(i,n) = K * a^n;  
    end
end
for n =1:20
    esforcoControleNoTempo(1,n) = sum(esforcoControleNoTempo(:,n));
end
for i = 7:-1:2
    esforcoControleNoTempo(i,:) = [];
end
esforcoControleNoTempo
t = dt:dt:0.02;
u = ones(size(t));
L = lsim(Gd,u,t);
figure;
plot(t,L,'o');
figure;
plot(t,esforcoControleNoTempo,'o');







