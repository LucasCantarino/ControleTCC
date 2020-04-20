function [erro] = FOB(k)


Kp = k(1); Ki = k(2); Kd = k(3); Tf = k(4);
s=tf('s');
b = 0.055;
P = tf(1,[b 1])*tf(1,[0.125 0])
C = Kp + Ki/s + Kd*s/(Tf*s+1)
F = feedback(P*C,1)
RespostaDegrau = F/s

% Extract the numerator/denominator
[num,den] = tfdata(RespostaDegrau);

% Build symbolic expression using the numerator/denominator
syms s;
arrayNum = cell2mat(num);
arrayDen = cell2mat(den);
RespostaDegrauSym = poly2sym(arrayNum,s)/poly2sym(arrayDen,s)

% Calculando a inversa de laplace

syms t;
funcaoNoTempo = vpa(ilaplace(RespostaDegrauSym,t))

% O erro é calculado como diferença entre o degrau de referência e a
% integrau da função da resposta ao degrau. O erro é calculado do tempo t = 0 até o tempo t = 0.1 

erro = 0.1 - int(funcaoNoTempo,t,0,0.1)


