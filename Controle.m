clc; close all; clear all;

dt = 0.001;
t = 0:dt:1.4;
u = 1000*ones(size(t));

% %esquerdo
% a1 = 0.01167;
% b1 = 0.2;
% 
% %direito
% a2 = 0.01021;
% b2 = 0.2;

%Valores obtidos através da média das medições em estado permanente

%esquerdo
a1 = 0.0115;
b1 = 0.2;

%direito
a2 = 0.0101;
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

%controlador para degrau maximo de 1,152 (pwm de 355) e response time 0.111 (padrão)
KpL = 308.2;
KiL = 1540;
KpR = 353.5;
KiR = 1766;

%controlador para degrau maximo de 1,7 (pwm de 240) e response  time 0.1625 (novo)

% KpL = 308.2;
% KiL = 1540;
% KpR = 353.5;
% KiR = 1766;

%controlador para degrau maximo de 1.7 (pwm de 155) e response time 0.252 (padrão)

% KpL = 136.3563;
% KiL = 680.0814;
% KpR = 155.859;
% KiR = 777.331;

PID_L = KpL + KiL*tf(1,[1 0]);
PID_R = KpR + KiR*tf(1,[1 0]); %+ tf([KdR,0],[TfR,1]); %PIDF

PID_Ld = c2d(PID_L,dt,'tustin');
PID_Rd = c2d(PID_R,dt,'tustin');

MalhaInternaLd = feedback(PID_Ld*G_Ld,1);
MalhaInternaRd = feedback(PID_Rd*G_Rd,1);

t = 0:dt:0.6;
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

int = tf(1,[0.125 0]);
intd = c2d(int,dt,'tustin');
PdL = G_Ld * intd;
PdR = G_Rd * intd;
% Para PIDF com response time = 0.0997 e transient behaviour =
% 0.6 (esforço máximo de 5122)

% Parâmetros obtidos pelo Pid Tuner para esforço máximo de 5122

% KpR = 422.3
% KiR = 882.9
% KdR = 45.13
% TfR = 0.0093

% KpL = 408.9
% KiL = 856.1
% KdL = 42.4
% TfL = 0.009026

% Parâmetros obtidos pelo fmincon para esforço máximo de 5122

% KpL = 355.1528
% KiL = 910.2095
% KdL = 49.6918
% TfL = 0.0099

% KpR = 380.4731
% KiR = 709.8596
% KdR = 53.0524
% TfR = 0.0107

% Parâmetros obtidos pelo bat para esforço máximo de 5122

KpL = 453.4305
KiL = 1168.7579
KdL = 66.2625
TfL = 0.0139

KpR = 87.1558
KiR = 1637.7642
KdR = 155.7484
TfR = 0.0310

% Parâmetros obtidos pelo GWO

% Para esforço de controle de 8316 para a malha externa:

% Para PIDF com response time = 0.0776 e transient behaviour =
% 0.6 (esforço máximo de 8316)

% Parâmetros obtidos pelo Pid Tuner para esforço máximo de 8316

% KpL = 533.5934
% KiL = 1331.0677
% KdL = 51.382
% TfL = 0.007614
% 
% KpR = 609.8957
% KiR = 1521.4064
% KdR = 58.7295
% TfR = 0.007614

% Parâmetros obtidos pelo fmincon para esforço máximo de 8316

% KpL = 257.6467
% KiL = 1369.061
% KdL = 147.7741
% TfL = 0.01784
% 
% KpR = 257.6467
% KiR = 1369.061
% KdR = 147.7741
% TfR = 0.01784

% Parâmetros obtidos pelo bat para esforço máximo de 8316

% KpL = 118.7955
% KiL = 215.1321
% KdL = 119.9788
% TfL = 0.01436
% 
% KpR = 118.7955
% KiR = 215.1321
% KdR = 119.9788
% TfR = 0.01436

% Parâmetros obtidos pelo GWO para esforço máximo de 8316

% KpL = 354.673
% KiL = 1840.4043
% KdL = 87.3903
% TfL = 0.02617
% 
% KpR = 354.4542
% KiR = 1839.8016
% KdR = 87.3903
% TfR = 0.02617

CL = KpL + tf(KiL,[1 0]) + tf([KdL 0],[TfL 1]);
CR = KpR + tf(KiR,[1 0]) + tf([KdR 0],[TfR 1]);

CdL = c2d(CL,dt,'tustin');
CdR = c2d(CR,dt,'tustin');

PcL = feedback(CdL*PdL,1);
PcR = feedback(CdR*PdR,1);

t = 0:dt:0.6;
respostaDegrauL = step(PcL,t)';
respostaDegrauR = step(PcR,t)';

figure;
step(PcL,t);
hold on;
step(PcR,t);

esforcoControleL = step(CdL/(1+(CdL*PdL)),t)';
esforcoControleR = step(CdR/(1+(CdR*PdR)),t)';

figure;
step(CdL/(1+(CdL*PdL)),t);
hold on;
step(CdR/(1+(CdR*PdR)),t);

flag =0;
St = 10;
respostaDegrauAnterior = 0;

for i = 1:601
    if (flag ==0 && respostaDegrauL(i)>=1)
        TsL = (i-1)/1000
        flag =1;
    end
    if (flag ==1 && respostaDegrauAnterior>respostaDegrauL(i))
        MpL = respostaDegrauAnterior
        flag = 2;
    end
    if (flag ==2 && respostaDegrauL(i)<=1.02)
        StL = (i-1)/1000
        flag = 3;
    end
    respostaDegrauAnterior = respostaDegrauL(i);
    erroParcial(i) = (1 - respostaDegrauL(i))^2;
end
erroTotalL = sum(erroParcial) 
erroPenalizadoL = erroTotalL + exp(esforcoControleL(1)-8316)

flag =0;
St = 10;
respostaDegrauAnterior = 0;

for i = 1:601
    if (flag ==0 && respostaDegrauR(i)>=1)
        TsR = (i-1)/1000
        flag =1;
    end
    if (flag ==1 && respostaDegrauAnterior>respostaDegrauR(i))
        MpR = respostaDegrauAnterior
        flag = 2;
    end
    if (flag ==2 && respostaDegrauR(i)<=1.02)
        StR = (i-1)/1000
        flag = 3;
    end
    respostaDegrauAnterior = respostaDegrauR(i);
    erroParcial(i) = (1 - respostaDegrauR(i))^2;
end
erroTotalR = sum(erroParcial) 
erroPenalizadoR = erroTotalR + exp(esforcoControleR(1)-8316)