
function DeltaErro = SimulaProcesso(K ,  plot_sim, modo) % Recebe como parãmetros Kp, Ki, Kd,
                                                        % o raio e o ãngulo do ponto objetivo,                            
                                                        % uma flag indicado se é para plotar,
                                                        % e um parãmetro que diz respeito
                                                        % à forma como o erro será calculado 

Kp = K(1);             % Armazena o valor de Kp que está no vetor K
Ki = K(2);             % Armazena o valor de Ki que está no vetor K
Kd = K(3);             % Armazena o valor de Kd que está no vetor K

v = 0.25;           % Limita a velocidade linear
wmax = deg2rad(300);   % Limita a velocidade angular
int_alpha = 0;         % Inicializando a integral de alpha como 0
t = 0;                 % Inicializando o tempo como 0          
alpha_old = 0;         % Inicializando o alpha antigo como 0
dt = 0.1;              % Iniciando o delta t como 0.1
delta = 0.1;           % Iniciando o delta como 0.1

Corpo = [ 100 , 227.5, 227.5 , 100   , -200   , -227.5 , -227.5 , -200
    -190.5 , -50 , 50   , 190.5 ,  190.5 ,  163   , -163   , -190.5]/2000;

Corpo = [Corpo ; [1 1 1 1 1 1 1 1]];

RodaE = [ 97.5  97.5 -97.5 -97.5
    170.5 210.5 210.5 170.5]/2000;

RodaE = [RodaE; [1 1 1 1]];

RodaD = [ 97.5  97.5 -97.5 -97.5
    -170.5 -210.5 -210.5 -170.5]/2000;

RodaD = [RodaD; [1 1 1 1]];

P = [0;
    0;
    deg2rad(0)];
R = P;

r = 1/2 * (195/1000);

l = 1/2 * (381/1000);

Pini = P;
raio = [2 1];
angulo = [73 92];

n = 2;
    for cont =1:1:n
        g_r(cont) = raio(cont);              % Definindo a distância do objetivo
        g_th(cont) = deg2rad(angulo(cont));  % Definindo o ângulo do objetivo
        G = [Pini(1) + g_r(cont) * cos(g_th(cont));
            Pini(2) + g_r(cont) * sin(g_th(cont));];

        a = G(2) - Pini(2);

        b = Pini(1) - G(1);

        c = G(1) * Pini(2) - Pini(1) * G(2);

        Erro = abs(a * P(1) + b * P(2) + c)/sqrt(a^2 + b^2); % Distância euclidiana do robô à reta

        tmax = 10 * sqrt((G(1) - Pini(1))^2 + (G(2) - Pini(2))^2)/v;

        Dx = G(1) - P(1);
        Dy = G(2) - P(2);

        rho = sqrt(Dx^2 + Dy^2);  % Distância euclidiana do robô ao ponto objetivo

        gamma = AjustaAngulo(atan2(Dy , Dx));

        alpha = AjustaAngulo(gamma - P(3)); % Ângulo de orientação do robô ao ponto objetivo 
         while (rho > delta) && (t <= tmax) % Enquanto a distância euclidiana do robô ao ponto objetivo for menor que a tolerância

             t = t + dt;              % Atualiza o tempo

             Dx = G(1) - P(1);        % Atualiza a diferença entre o x do objetivo e o x do robô
             Dy = G(2) - P(2);        % Atualiza a diferença entre o y do objetivo e o y do robô 

             rho = sqrt(Dx^2 + Dy^2); % Distância euclidiana do robô ao ponto objetivo

             gamma = AjustaAngulo(atan2(Dy , Dx)); 

             alpha = AjustaAngulo(gamma - P(3));

             dif_alpha = (alpha - alpha_old); alpha_old = alpha; % Calcula a difrença entre o alpha e o alpha antigo 
                                                                 % e atualiza o
                                                                 % alfa antigo com
                                                                 % o alfa atual

             int_alpha = int_alpha + alpha;  % Somatório do alpha

             w = Kp * alpha + Ki * int_alpha + Kd * dif_alpha; % Calcula o módulo da velocidade angular

             w = sign(w) * min(abs(w) , wmax); % Calcula o sinal da velocidade angular e a limita

             dPdt = [v * cos(P(3));
                 v * sin(P(3));
                 w];

             P = P + dPdt * dt;
             P(3) = AjustaAngulo(P(3)); % Chama a função quee ajusta o ângulo pra a faixa de -180° a 180° 

             R = [R , P];
             Erro = [Erro; abs(a * P(1) + b * P(2) + c)/sqrt(a^2 + b^2)]; % Atualiza o vetor de erros com a distância do robô à reta

             if plot_sim == 1            % Se plot_sim é 1              
 %%%%%%%%%%%%%%%%%%%%%%%%%%%Plot dO Robô%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                % Corpo do robô
                RoboC = T2D(Rz2D(Corpo , P(3)) , P(1) , P(2)); % incremental
                %Roda Esquerda do robô
                RoboE = T2D(Rz2D(RodaE , P(3)) , P(1) , P(2)); % incremental
                %Roda Direita do robô
                RoboD = T2D(Rz2D(RodaD , P(3)) , P(1) , P(2)); % incremental
                % 
                % Plot

                subplot(1,2,1)
                plot([Pini(1) G(1)] , [Pini(2) G(2)] , 'g' , 'linewidth' , 2); hold on;
                plot(G(1) , G(2) , 'ok' , 'linewidth' , 2 , 'markersize' , 3);
                % 
                % Robô
                fill(RoboC(1,:) , RoboC(2,:) , 'r') % corpo
                fill(RoboE(1,:) , RoboE(2,:) , 'r') % roda esquerda
                fill(RoboD(1,:) , RoboD(2,:) , 'r') % roda direita
                % 
                % Histórico de posições: o 'rastro' do robô, por onde ele passou.
                plot(R(1,:) , R(2,:) , 'b' , 'linewidth' , 2);
                % 
                % Orientação atual do robô: para onde ele aponta no momento atual 't'
                plot([P(1) P(1)+0.1*cos(P(3))] , [P(2) P(2)+0.1*sin(P(3))] , 'k' , 'linewidth' , 2)
                % 
                % Eixo das rodas
                %plot([P(1) P(1)+l*cos(P(3)+pi/2)] , [P(2) P(2)+l*sin(P(3)+pi/2)] , 'k' , 'linewidth' , 2)
                %plot([P(1) P(1)+l*cos(P(3)-pi/2)] , [P(2) P(2)+l*sin(P(3)-pi/2)] , 'k' , 'linewidth' , 2)
                scatter(P(1) , P(2) , 50 , 'r')
                scatter(G(1) , G(2) , 50 , 'r')
                grid on
                hold off;axis equal; grid on; xlabel('x') ; ylabel('y'); set(gcf,'color','w');
                title(sprintf('t = %.fs, Erro = % .2fm' , t , Erro(end))); drawnow;


                subplot(1,2,2)
                plot(Erro,'b'); hold on
                title('Erro')
                grid on; xlabel('x') ; ylabel('y'); set(gcf,'color','w'); hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             end
         end
         if modo == 1                 % Se o modo é 1
            DeltaErro = mean(Erro);   % DeltaErro é calculado pela média
         end

         if modo == 2                 % Se o modo é 2
            DeltaErro = std(Erro);    % DeltaErro é calculado pelo desvio padrão
         end
         end
         Pini = P;
end