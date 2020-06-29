function [erroPenalizado] = FOB(k)
dt = 0.001;
Kp = k(1); Ki = k(2); Kd = k(3); Tf = k(4);
G_Ld = tf([2.91e-5 2.91e-5],[1 -0.995],dt);
G_Rd = tf([2.546e-5 2.546e-5],[1 -0.995],dt);
int = tf(1,[0.125 0]);
intd = c2d(int,dt,'tustin');
Gd = G_Rd;
Pd = Gd * intd;
C = Kp + tf(Ki,[1,0]) + tf([Kd,0],[Tf,1]);
Cd = c2d(C,dt,'tustin');
Pc = feedback(Cd*Pd,1);
t = 0:dt:0.6;
respostaDegrau = step(Pc,t)';
esforcoControle = step(Cd/(1+(Cd*Pc)),t)';
flag =0;
St = 10;
respostaDegrauAnterior = 0;
for i = 1:601
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
esfocoControleMax = esforcoControle(1)
erroTotal = sum(erroParcial) 
erroPenalizado = erroTotal + exp(esfocoControleMax-5122)
