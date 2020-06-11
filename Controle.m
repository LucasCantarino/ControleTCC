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
% KpR = 354.1229;    % PIDF
% KiR = 1841.178;
% KdR = 9.5987;
% TfR = 0.268;

PID_L = KpL + KiL*tf(1,[1 0]);
PID_R = KpR + KiR*tf(1,[1 0]); %+ tf([KdR,0],[TfR,1]); PIDF

PID_Ld = c2d(PID_L,dt,'tustin');
PID_Rd = c2d(PID_R,dt,'tustin');

MalhaInternaLd = feedback(PID_Ld*G_Ld,1);
MalhaInternaRd = feedback(PID_Rd*G_Rd,1);

t = 0:dt:0.5;
u = 1000*ones(size(t));
vL_pid = lsim(MalhaInternaLd,0.001*u,t);
vR_pid = lsim(MalhaInternaRd,0.001*u,t);

figure
plot(t,vL_pid,'b')
hold on
plot(t,vR_pid,'r')

RespostaDegrauL = MalhaInternaLd/G_Ld;
RespostaDegrauR = MalhaInternaLd/G_Rd;
figure
step(RespostaDegrauL,t);
hold on;
step(RespostaDegrauR,t);
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
Kp = 128.5694
Ki = 3423.6
Kd = 6.4898
Tf = 5.5823e-04
C = Kp + tf(Ki,[1,0]) + tf([Kd,0],[Tf,1]);
Cd = c2d(C,dt,'tustin');
Gd = feedback(Cd*Pd,1);
t = 0:dt:0.02;
respostaDegrau = step(Gd,t)';
figure;
step(Gd,t);
esforcoControle = step(Cd/(1+(Cd*Pd)),t)';
figure;
step(Cd/(1+(Cd*Pd)),t);
flag =0;
St = 10;
respostaDegrauAnterior = 0;
for i = 1:21
    if (flag ==0 && respostaDegrau(i)>=1)
        Ts = (i-1)/1000
        flag =1;
    end
    if (flag ==1 && respostaDegrauAnterior>respostaDegrau(i))
        Mp = respostaDegrauAnterior
        flag = 2;
    end
    if (flag ==2 && respostaDegrau(i)<=1.02)
        St = (i-1)/1000
        flag = 3;
    end
    respostaDegrauAnterior = respostaDegrau(i);
    erroParcial(i) = (1 - respostaDegrau(i))^2;
end
erroTotal = sum(erroParcial) 
erroPenalizado = erroTotal + exp(esforcoControle(1)-5122)







