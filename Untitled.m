clear; clc; close all;
% ============
% Sistema real
% ============
rng(8); % semente para a repetitividade dos resultados
% Estado inicial do sistema linear a ser rastreado
x = [0 % altitude inicial
0]; % velocidade inicial
X = x; % histórico dos estados (para fazer plot)
% Tempo de amostragem do sistema real
dt = 0.1; % s
% Matriz transição de estados do sistema
A = [1 dt
0 1];
% Matriz de controle
B = [dt^2 /2
dt];
% Aceleração (sinal/lei de controle)
a = 0.1;
u = a;
% Erros do sistema rastreado
sigma_x_s = 0.01; % desvio padrão de s [m]
sigma_x_v = 0.02; % desvio padrão de v [m/s]
% Matriz de covariâncias (erros) do sistema rastreado
Q = [sigma_x_s^2 0
0 sigma_x_v^2];
% ===============
% LOOP DO SISTEMA
% ===============
t = 0; % tempo da simulação
tmax = 30; % tempo máximo da simulação

% ===========
% Sensor real
% ===========
% Matriz do sensor
C = [1 0];
% Erros do sensor
sigma_y_s = 5; % desvio padrão do sensor do estado s [m]
% Matriz de covariâncias do sensor
R = sigma_y_s^2;
% Primeira leitura do sensor
y = C * x + sqrt(R) * randn; % altere para locais diferentes
Y = y; % armazenamento do sensor (plot)

% Estado inicial da Esperança do sistema
xK = [x(1); 0]; % também é usual fazer o primeiro estado igual ao sensor
XK = xK; % Armazenamento dos estados da Esperança (plot)
% Covariância inicial da Esperança do erro e(k)
P = Q; % Usual, uma vez que sempre existe incerteza no valor inicial
% Leitura inicial da Esperança do sensor
z = C * xK;
Z = z; % Armazenamento dos estados da Esperança (plot)
e = abs(x(1,1)-z); % Erro entre o estado real e sua esperança


while t <= tmax
% ==============================
% Evolução do tempo da simulação
% ==============================
t = [t , t(end) + dt];
% ==========================================
% Evolução do sistema linear a ser rastreado
% ==========================================
x = A * x + B * u + sqrt(Q) * randn(size(x));
X = [X , x]; % armazenamento dos estados para plot

% ===========================
% Leitura de um sensor 'real'
% ===========================
y = C * x + sqrt(R) * randn;
Y = [Y , y]; % armazenamento do sensor (plot)

% ==========================================
% PREDIÇÃO DOS ESTADOS POR MEIO DA ESPERANÇA
% ==========================================
% Usa-se a Esperança do sistema real (sem erros aleatórios
% inseridos) para se ter uma estimativa dos seus estados.
% Obtenção da predição: modelo dado pela Esperança:
xK = A * xK + B * u;
% Cálculo da covariância (espalhamento) da Esperança do sistema:
P = A * P * A' + Q;
% Esperança do sensor:
z = C * xK;
Z = [Z , z]; % Armazenamento dos estados da esperança do sensor
e = [e , abs(x(1,end) - z)]; % Erro entre o estado real e sua esperança
% =========================================
% FILTRO DE KALMAN: CORREÇÃO DAS ESPERANÇAS
% =========================================
% Cálculo do Ganho de Kalman
K = P * C' * (C * P * C' + R)^-1;
% Outra maneira de escrever: K = (C * P * C' + R)\P * C'
% Outra maneira de escrever: K = P * C' * inv(C * P * C' + R);
% Correção da esperança do sistema
xK = xK + K * (y - z);
XK = [XK , xK]; % Coloque o armazenador depois da correção
% Correção da covariância do modelo matemático
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