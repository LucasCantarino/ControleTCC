%FOB para o motor direito

function [erroPenalizado] = FOB_malha_interna(k)
dt = 0.001;
Kp = k(1); Ki = k(2);
a = 0.01021;
b = 0.2;
P = tf(a,[b 1]);
Pd = c2d(P,dt,'tustin');
C = Kp + tf(Ki,[1,0]);
Cd = c2d(C,dt,'tustin');
Gd = feedback(Cd*Pd,1);
t = 0:dt:0.6;
respostaDegrau = step(Gd,t)';
esforcoControle = step(Cd/(1+(Cd*Pd)),t)';
flag = 0;
St = 10;
respostaDegrauAnterior = 0;
for i = 1:601
    if (flag == 0 && respostaDegrau(i)<=0.6)
        Ts = respostaDegrau(i)
        flag =1;
    end
    if (flag ==1 && respostaDegrauAnterior>=respostaDegrau(i))
        Mp = respostaDegrauAnterior
        flag = 2;
    end
    if (flag ==2 && respostaDegrau(i)>=0.98)
        St = (i-1)/1000
        flag = 3;
    end
    respostaDegrauAnterior = respostaDegrau(i);
    erroParcial(i) = (1 - respostaDegrau(i))^2;
end
esforcoDeControleMax = esforcoControle(1)
erroTotal = sum(erroParcial) 
erroPenalizado = erroTotal + exp(esforcoControle(1)-355)
