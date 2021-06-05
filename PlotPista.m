%{
Código para a plotagem da pista no matlab utilizando as dimensões
adquiridas por uma foto da pista.
%}
clc; clear all; close all;

n = 37;%9; %número de trechos.

%tipo = 0; % 0 = reta; 1 = curva para a direita; 2 = curva para a esquerda;

P_ini= [-80 0]; %Ponto inicial (sempre na origem)
%{
  representação dos elementos de P:
  P(n) = [x,y,raio,sentido]
  Se o dado trecho for uma reta, os valores de raio e sentido serão 0.
  Se sentido = 1: Curva para a direita.
  Se sentido = 2: Curva para a esquerda.

  x e y se referem às coordenadas finais do trecho ao qual raio e sentido
  se referem.
%}

P = [-273.0 0 0 0 0;
     -283 10 10 1 pi/2;
     -283 21 0 0 0;
     -273 31 10 1 pi/2;
     -273 54 11.5 2 pi;
     -273 77 11.5 1 pi;
     -273 100 11.5 2 pi;
     -283 110 10 1 pi/2;
     -283 123.8 0 0 0;
     -250.5 156.3 32.5 1 pi/2;
     -176 156.3 0 0 0;
     -164.5 144.8 11.5 1 pi/2;
     -164.5 52.8 0 0 0;
     -131.5 52.8 16.5 2 pi;
     -131.5 142.3 0 0 0;
     -103.5 142.3 14 1 pi;
     -103.5 59.8 0 0 0;
     -80 83.3 23.5 2 3*pi/2;
     -194.5 83.3 0 0 0;
     -204.5 73.3 10 2 pi/2;
     -204.5 50.8 0 0 0;
     -233.5 50.8 14.5 1 pi;
     -233.5 114.3 0 0 0
     -223.5 124.3 10 1 pi/2;
     5.5 124.3 0 0 0;
     15.5 134.3 10 2 pi/2;
     15.5 146.3 0 0 0;
     5.5 156.3 10 2 pi/2;
     -20.5 156.3 0 0 0;
     -30.5 146.3 10 2 pi/2;
     -30.5 72.3 0 0 0;
     -20.5 62.3 10 2 pi/2;
     5.5 62.3 0 0 0;
     15.5 52.3 10 1 pi/2;
     15.5 10 0 0 0
     5.5 0 10 1 pi/2
     -80 0 0 0 0];%[1.0 0 0 0;1.1 -0.1 0.1 1;1.1 -1.1 0 0;1.0 -1.2 0.1 1;-1.0 -1.2 0 0;...
    %-1.1 -1.1 0.1 1;-1.1 -0.1 0 0;-1.0 0 0.1 1;0 0 0 0];% 

t = 2; %contador de interações do while. Começa em 2 pois a primeira iteração
       %ocorre fora do while.

plot([P_ini(1) P(1,1)],[P_ini(2) P(1,2)],'g','linewidth',2);hold on;

theta = -pi/2%-pi/2;%ângulo inicial para a construção da pista.
dtheta = P(t,5);%pi/2;%ângulo para a construção de cada curva.

while(t <= n)
    
    %G = [P(t,1) P(t,2)];
    if(P(t,3) > 0)
 
        centro = centro_theta(theta,P(t,3),P(t,4),P(t-1,:),P(t,:));
        
%         if(cos(theta) > 1e-15 && sin(theta) >= 0)
%             theta = pi-asin(sin(theta));
%         elseif(cos(theta) > 1e-15 && sin(theta)< 0)
%             theta = 3*pi - asin(sin(theta));
%         end
        
%         if(cos(theta) > 0 && sin(theta) >= 0)
%             theta = -pi - theta;
%         elseif(cos(theta) > 0 && sin(theta)< 0)
%             theta = 3*pi - theta;
%         end
        
%         if(theta >= 0)
%             ang=theta-P(t,5):(0.01):theta;%dtheta; 
%         else
%             ang=theta:(-0.01):theta-P(t,5);%dtheta;
%         end

        if(t == 18 || t == 20 || t == 26 || t == 28 || t == 30 || t == 32)
            theta1 = theta;
            theta = theta-pi;
            ang=theta:(0.01):theta+P(t,5);%dtheta;
            theta = theta1;
        else
            ang=theta:(-0.01):theta-P(t,5);%dtheta;
        end

        %ang=theta:(-0.01):theta-P(t,5);%dtheta;
        xp=P(t,3)*cos(ang);%0.1*cos(ang);
        yp=P(t,3)*sin(ang);%0.1*sin(ang);
        plot(centro(1)+xp,centro(2)+yp,'g','linewidth',2);hold on;
        axis([-300 20 -20 300])%axis([-0.1 1.1 -1.2 0])
        axis('square');
        if(P(t,4) == 1)
            theta = theta-P(t,5);
        elseif(P(t,4) == 2)
            theta = theta+P(t,5);
        end
        %theta = theta-P(t,5);
        theta = rem(theta,2*pi);
    else
       plot([P(t-1,1) P(t,1)],[P(t-1,2) P(t,2)],'g','linewidth',2);hold on; 
    end
    t=t+1;
    
end
% G = [0 0]; %ponto final
% 
% trechos = []



