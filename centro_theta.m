%fun��o para o c�lculo do centro das curvas da pista e do �ngulo theta
%formado entre os pontos final e inicial.

function [centro] = centro_theta(theta,raio,sentido,P,G)

    %defini��o do centro
    
    if(sentido == 1)
        
        centro = [P(1)+raio*cos(theta+pi);P(2)+raio*sin(theta+pi)]
        
    elseif(sentido == 2)
        
        centro = [P(1)+raio*cos(theta);P(2)+raio*sin(theta)]
        
    end
    
    %defini��o de dtheta
    
    

end