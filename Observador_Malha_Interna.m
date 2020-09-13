clc; clear all; close all;

%esquerdo
a_L = 0.01167;
b_L = 0.2;

%direito
a_R = 0.01021;
b_R = 0.2;

b_L = [b_L 1];
b_R = [b_R 1];

[A_L,B_L,C_L,D_L] = tf2ss(a_L,b_L)
[A_R,B_R,C_R,D_R] = tf2ss(a_R,b_R)

a1_L = - A_L
a1_R = - A_R

N_L = C_L'
N_R = C_R'

W_L = 1
w_R = 1

Q_L = 1/C_L
Q_R = 1/C_R

G_L = tf(a_L,b_L);
G_R = tf(a_R,b_R);

KpL = 136.3563;
KiL = 680.0814;
KpR = 155.859;
KiR = 777.331;

PID_L = KpL + KiL*tf(1,[1 0]);
PID_R = KpR + KiR*tf(1,[1 0]);

MalhaInternaL = feedback(PID_L*G_L,1)
MalhaInternaR = feedback(PID_R*G_R,1)

MalhaInterna = [0.2 1 2.591 7.937];
MalhaInterna = [0.2 1 2.591 7.937]/MalhaInterna(1)
mi = roots(MalhaInterna)
miObservador = real(3.5*mi)
alfa1 = MalhaInterna(2)
syms s;
(s-miObservador(1))*(s-miObservador(2))*(s-miObservador(3))
Ke_L = Q_L*(alfa1 - a1_L)
Ke_R = Q_R*(alfa1 - a1_R)

