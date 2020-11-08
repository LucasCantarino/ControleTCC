clear; clc; close all;
% ============
% Sistema real
% ============
rng(8); % semente para a repetitividade dos resultados
% Estado inicial do sistema linear a ser rastreado
x = [0 % altitude inicial
0]; % velocidade inicial
X = x; % hist�rico dos estados (para fazer plot)
% Tempo de amostragem do sistema real
dt = 0.1; % s
% Matriz transi��o de estados do sistema
A = [1 dt
0 1];
% Matriz de controle
B = [dt^2 /2
dt];
% Acelera��o (sinal/lei de controle)
a = 0.1;
u = a;
% Erros do sistema rastreado
sigma_x_s = 0.01; % desvio padr�o de s [m]
sigma_x_v = 0.02; % desvio padr�o de v [m/s]
% Matriz de covari�ncias (erros) do sistema rastreado
Q = [sigma_x_s^2 0
0 sigma_x_v^2];
% ===============
% LOOP DO SISTEMA
% ===============
t = 0; % tempo da simula��o
tmax = 30; % tempo m�ximo da simula��o

% ===========
% Sensor real
% ===========
% Matriz do sensor
C = [1 0];
% Erros do sensor
sigma_y_s = 5; % desvio padr�o do sensor do estado s [m]
% Matriz de covari�ncias do sensor
R = sigma_y_s^2;
% Primeira leitura do sensor
y = C * x + sqrt(R) * randn; % altere para locais diferentes
Y = y; % armazenamento do sensor (plot)

% Estado inicial da Esperan�a do sistema
xK = [x(1); 0]; % tamb�m � usual fazer o primeiro estado igual ao sensor
XK = xK; % Armazenamento dos estados da Esperan�a (plot)
% Covari�ncia inicial da Esperan�a do erro e(k)
P = Q; % Usual, uma vez que sempre existe incerteza no valor inicial
% Leitura inicial da Esperan�a do sensor
z = C * xK;
Z = z; % Armazenamento dos estados da Esperan�a (plot)
e = abs(x(1,1)-z); % Erro entre o estado real e sua esperan�a


while t <= tmax
% ==============================
% Evolu��o do tempo da simula��o
% ==============================
t = [t , t(end) + dt];
% ==========================================
% Evolu��o do sistema linear a ser rastreado
% ==========================================
x = A * x + B * u + sqrt(Q) * randn(size(x));
X = [X , x]; % armazenamento dos estados para plot

% ===========================
% Leitura de um sensor 'real'
% ===========================
y = C * x + sqrt(R) * randn;
Y = [Y , y]; % armazenamento do sensor (plot)

% ==========================================
% PREDI��O DOS ESTADOS POR MEIO DA ESPERAN�A
% ==========================================
% Usa-se a Esperan�a do sistema real (sem erros aleat�rios
% inseridos) para se ter uma estimativa dos seus estados.
% Obten��o da predi��o: modelo dado pela Esperan�a:
xK = A * xK + B * u;
% C�lculo da covari�ncia (espalhamento) da Esperan�a do sistema:
P = A * P * A' + Q;
% Esperan�a do sensor:
z = C * xK;
Z = [Z , z]; % Armazenamento dos estados da esperan�a do sensor
e = [e , abs(x(1,end) - z)]; % Erro entre o estado real e sua esperan�a
% =========================================
% FILTRO DE KALMAN: CORRE��O DAS ESPERAN�AS
% =========================================
% C�lculo do Ganho de Kalman
K = P * C' * (C * P * C' + R)^-1;
% Outra maneira de escrever: K = (C * P * C' + R)\P * C'
% Outra maneira de escrever: K = P * C' * inv(C * P * C' + R);
% Corre��o da esperan�a do sistema
xK = xK + K * (y - z);
XK = [XK , xK]; % Coloque o armazenador depois da corre��o
% Corre��o da covari�ncia do modelo matem�tico
P = (eye(size(Q)) - K * C) * P;

% ====
% Plot
% ====
plot(t , Y , 'g' , 'linewidth' , 2)
hold on
plot(t , X(1,:) , 'k' , 'linewidth' , 2)
plot(t , Z , 'r' , 'linewidth' , 2)
plot(t(end) , x(1) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
plot(t(end) , xK(1) , 'or' , 'linewidth' , 2 , 'markersize' , 10)
hold off; grid on; xlabel('tempo [s]');ylabel('altitude [m]');
axis([t(1) t(end) min([X(1,1) Y Z]) max([X(1,:) Y Z])]); drawnow;
end