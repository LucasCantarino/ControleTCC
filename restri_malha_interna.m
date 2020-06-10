function [c,ceq] = restri(k)
dt = 0.001;
Kp = k(1); Ki = k(2);
a = 0.01021;
b = 0.2;
P = tf(a,[b 1]);
Pd = c2d(P,dt,'tustin');
C = Kp + tf(Ki,[1,0]);
Cd = c2d(C,dt,'tustin');
Gd = feedback(Cd*Pd,1);
t = 0:dt:0.02;
respostaDegrau = step(Gd,t)';
esforcoControle = step(Cd/(1+(Cd*Pd)),t)';
flag =0;
St = 10;
respostaDegrauAnterior = 0;
Ts = 10;
for i = 1:21
    if ((flag ==0 && (1 - respostaDegrau(i))<=0.05)||i == 21)
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
end
EsforcoMax = esforcoControle(1);
c(1) = Ts - 0.05;
c(2) = Mp - 1.2;
c(3) = St - 0.3;
c(4) = EsforcoMax - 5122;
ceq = [];