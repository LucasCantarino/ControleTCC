clear; clc; close all;

K = [0 0 0];   % Cria as constantes Kp, Ki e Kd iniciais

dK = [1 1 1];  % Estabelece as varia��es diferenciais iniciais de Kp, Ki e Kd

ksi = 1/100;   % Estabelece o incremento/decremento das varia��es diferenciais de Kp, Ki e Kd

delta = 0.001  % Estabelece a toler�ncia ao erro

% Para usar a m�dia no c�lculo do erro, escolha modo = 1
% Para usar desvio padr�o no c�lculo do erro, escolha modo = 2
modo = 1;

Erro_best = SimulaProcesso(K , 0, modo); % Calcula o erro ao percorrer a trajet�ria para dado conjunto K
                                         % O par�metro 0 � para que n�o seja plotada a simula��o
k = 0;% Contador de itera��es

 while sum(dK) > delta                   % Enquanto a soma de dK para cada K for menor que a toler�ncia do erro
    
     k = k+1;                            % Atualiza o n�mero da itera��o
      
     for i = 1:length(K)                 % Para Kp, Ki e Kd
         
         K(i) = K(i) + dK(i);            % Atualiza Kp, Ki e Kd somando dK
         
         Erro = SimulaProcesso(K , 0, modo); % Calcula o erro ao percorrer a trajet�ria para dado conjunto K
         
         if Erro < Erro_best                 % Se o erro atual for menor que o menor erro registrado
             
             Erro_best = Erro;               % Ent�o o erro atual � o novo menor erro
             
             dK(i) = dK(i) * (1+ksi);        % Dk aumeta para que o erro reduza ainda mais r�pido
             
         else                                % Sen�o
              
             K(i) = K(i) - 2*dK(i);          % Atualiza Kp, Ki e Kd subtraindo 2*dK
             
             Erro = SimulaProcesso(K , 0, modo); %  Calcula o erro ao percorrer a trajet�ria para dado conjunto K
             
             if Erro < Erro_best             % Se o erro atual for menor que o menor erro registrado
                 
                 Erro_best = Erro;           % Ent�o o erro atual � o novo menor erro
                 
                 dK(i) = dK(i) * (i + ksi);  % Dk aumeta para que o erro reduza ainda mais r�pido
                 
             else                            % Sen�o                   
                 
                 K(i) = K(i) + dK(i);        % Atualiza Kp, Ki e Kd somando dK (retornando aos valores do in�cio da itera��o
                 
                 dK(i) = dK(i) * (1 - ksi);  % dK diminui para que o algoritmo n�o oscile sem encontrar solu��o
                 
             end   
             
         end                                                            
         
         
     end
     fprintf('Rodada = %i: Melhor Erro = %.4f, soma(dK) = %.6f\n', k , Erro_best , sum(dK)) % Printa o n�mero da itera��o, 
                                                                                            % o menor erro encontrado
                                                                                            % e a soma das varia��es diferenciais iniciais de Kp, Ki e Kd
 end

fprintf('Parametros: P = %.4f, I = %.4f, D = %.4f', K(1) , K(2) , K(3))     % Printa os par�metros Kp, Ki e Kd otimizados 
                                                                            % Pelo Twiddle ap�s a condi��o de toler�ncia do erro ser atendida

SimulaProcesso(K, 1, modo);                                               % Plota o rob� se movendo a um ponto de raio 2 e �ngulo 45� (1� quadrante)
