function [erroPenalizado] = FOB(k)
dt = 0.001;
Kp = k(1); Ki = k(2); Kd = k(3); Tf = k(4); 
b = 0.055;
P = tf(1,[b 1])*tf(1,[0.125 0])
Pd = c2d(P,dt,'tustin')
C = Kp + tf(Ki,[1,0]) + tf([Kd,0],[Tf,1])
Cd = c2d(C,dt,'tustin')
Gd = feedback(Cd*Pd,1)
t = 0:dt:0.02;
respostaDegrau = step(Gd,t)';
esforcoControle = step(Cd/(1+(Cd*Pd)),t)';
flag =0;
St = 10;
respostaDegrauAnterior = 0;
for i = 1:21
    if (flag ==0 && respostaDegrau(i)>=1)
        Ts = (i-1)/1000
        flag =1;
    end
    if (flag ==1 && respostaDegrauAnterior>respostaDegrau(i))
        Mp = respostaDegrauAnterior
        flag = 2;
    end
    if (flag ==2 && respostaDegrau(i)<=1.02)
        St = (i-1)/1000
        flag = 3;
    end
    respostaDegrauAnterior = respostaDegrau(i);
    erroParcial(i) = (1 - respostaDegrau(i))^2;
end
erroTotal = sum(erroParcial) 
erroPenalizado = erroTotal + exp(esforcoControle(1)-5122)
