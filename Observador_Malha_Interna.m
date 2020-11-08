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

% Ambas malhas internas são iguais após o controle de malha fechada
% A variável abaixo foi definida copiando os valores das malhas internas calculadas pelo próprio MATLAB
NumeradorMalhaInterna = [1.591 7.937];
DenominadorMalhaInterna = [0.2 2.591 7.937];
[A,B,C,D] = tf2ss(NumeradorMalhaInterna,DenominadorMalhaInterna)
mi = roots(DenominadorMalhaInterna)
% Os polos do observador devem ser de 2 a 5 vezes o do controlador segundo
% os slides. Foi utilizado o sistema controlado realimentado pois o polo do
% controlador sozinho é 0.
miObservador = real(3.5*mi)

%A variável abaixo representa os coeficientes do polinômio (s-miObservador(1))*(s-miObservador(2))
DenominadorObservador = [1 12.955 4.9699]
alfa1 = DenominadorObservador(2)
alfa2 = DenominadorObservador(3)

% A multiplicação não poderia dar certo pois Q_L e Q_R são 1x1, mas o
% MATLAB está considerando como escalar e fazendo multiplicação escalar.
Ke_L = Q_L*[alfa1 - a1_L;
            alfa1 -   0 ]
Ke_R = Q_R*[alfa1 - a1_R;
            alfa1 -   0 ]
