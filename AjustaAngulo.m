%Função ajustaAngulo
%
%Converte um angulo para a faixa de [-180,180] graus.
%
%Exemplo:
%
%angulo = ajustaAngulo(390)
%
%angulo = 390-360
%
%angulo = 30

function angulo = ajustaAngulo(angulo)
      
angulo = mod(angulo , 2*pi);
if angulo > pi
    angulo = angulo - 2*pi;
end

end