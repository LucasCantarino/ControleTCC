clear all; clc; close all;

       p1 =       30.33
       p2 =      -65.24
       p3 =       58.41
       p4 =      -28.28
       p5 =       7.747
       p6 =      0.0063
       
syms x
vel = p1*x^5 + p2*x^4 + p3*x^3 + p4*x^2 + p5*x + p6;
acel = diff(vel);

K = [0 0 0];% matriz de ganhos PID

P = [0;0;deg2rad(0)];

g_th = deg2rad(45);

dK = [1,1,1]; %incrementos dos parâmetros

ksi = 1/100; %"incremento do incremento"

delta = 0.001; %critério de parada

[melhor_erro,~] = SimulaProcesso_foi(P,g_th,K,0);
erro_tempo = melhor_erro;

k = 0; %iterações

for j = 1:4

while sum(dK) > delta
    
    k = k+1;
    
    for i = 1:length(K)
    
        K(i) = K(i) + dK(i);
        [Erro,~] = SimulaProcesso_foi(P,g_th,K,0);
        
        if Erro < melhor_erro
            melhor_erro = Erro;
            
            dK(i) = dK(i) * (1+ksi);
        else
            
            K(i) = K(i) - 2*dK(i);
            
           [Erro,~] = SimulaProcesso_foi(P,g_th,K,0);
            
            if Erro < melhor_erro
                
                melhor_erro = Erro;
                
                dK(i) = dK(i)*(1 +ksi);
            else
                K(i) = K(i) + dK(i);
                dK(i) = dK(i)*(1-ksi);
            end
        end
    end
    fprintf('soma(dK = %.6f), Melhor Erro = %.4f, Rodada = %i\n',sum(dK),melhor_erro,k)
    erro_tempo = [erro_tempo,melhor_erro];
end

    fprintf('Parâmetros: P = %.4f, I = %.4f, D = %.6f\n',K(1),K(2),K(3))
    [melhor_erro,erro,P] = SimulaProcesso_foi(P,g_th,K,1);

    switch j
        case 1
            %P = [2;2;deg2rad(45)];
            g_th = deg2rad(0);
        case 2
            %P = [0;0;deg2rad(0)];
            g_th = deg2rad(-45);
        case 3
           % P = [0;0;deg2rad(0)];
            g_th = deg2rad(-90);
    end
    
%    figure(j+1)
%    t = 1:1:122;
%    plot(t,erro)
    title('Erro no tempo');grid on;
    xlabel('tempo[s]');ylabel('distância[m]')
    
    K = [0 0 0];% matriz de ganhos PID

    dK = [1,1,1]; %incrementos dos parâmetros

    ksi = 1/100; %"incremento do incremento"

    delta = 0.001; %critério de parada

    [melhor_erro,erro] = SimulaProcesso_foi(P,g_th,K,0);
    figure(1)

    k = 0; %iterações
    
end
