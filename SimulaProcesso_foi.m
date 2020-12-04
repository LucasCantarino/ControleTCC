function [DeltaErro,Erro,P_fin] = SimulaProcesso(P,g_th,K,plot_sim)
    Kp = K(1);
    Ki = K(2);
    Kd = K(3);

w = 0;

Corpo = [100, 227.5,227.5,100,-200,-227.5,-227.5,-200
        -190.5,-50,50,190.5,190.5,163,-163,-190.5]/1000;

Corpo = [Corpo;[1 1 1 1 1 1 1 1]];

RodaE = [97.5 97.5 -97.5 -97.5
        170.5 210.5 210.5 170.5]/1000;

RodaE = [RodaE;[1 1 1 1]];

RodaD = [97.5 97.5 -97.5 -97.5
        -170.5 -210.5 -210.5 -170.5]/1000;

RodaD = [RodaD;[1 1 1 1]];


R = P;

P_ini = P;

r = 1/2 * (195/1000);
l = 1/2 * (381/1000);

g_r = 2.8284;
G = [P_ini(1) + g_r*cos(g_th);P_ini(2) + g_r*sin(g_th)];

a = G(2) - P_ini(2);

b = P_ini(1) - G(1);

c = G(1)*P_ini(2) - P_ini(1)*G(2); %G(1) alterado para G(2)

Erro = abs(a*P(1)+b*P(2)+c)/sqrt(a^2 + b^2);

vmax = 0.25;
vfinal = 0.1;
wmax = deg2rad(300);

int_alpha = 0;
dif_alpha = 0;
alpha_old = 0;

t = 0;
tmax = 3*10*sqrt((G(1) - P_ini(1))^2 + (G(2) - P_ini(2))^2)/vmax;

delta = 0.1;

Dx = G(1) - P(1);
Dy = G(2) - P(2);

rho = sqrt(Dx^2 + Dy^2);
rhoinicial = rho;
gamma = AjustaAngulo(atan2(Dy,Dx));
alpha = AjustaAngulo(gamma - P(3));

dt = 0.1;

while ((rho > delta) && (t <= tmax))
    
    t = t + 1;%t em milésimos de segundo.
    %acel_num = 
    

    Dx = G(1) - P(1);
    Dy = G(2) - P(2);

    rho = sqrt(Dx^2 + Dy^2);
    
    %rho = max(rho,vfinal);

    gamma = AjustaAngulo(atan2(Dy,Dx));

    alpha = AjustaAngulo(gamma - P(3));
    
    int_alpha = int_alpha + alpha;
    dif_alpha = (alpha - alpha_old);
    alpha_old = alpha;
    
    %v = min(rho,vmax);
    
    if(rho <= rhoinicial/4)
        v = vfinal;
    else
        v = min(rho,vmax);
    end

    if (abs(alpha) > pi/2)
        v = -v;
        alpha = AjustaAngulo(alpha+pi);
    end
    
    w_old = w;
    w = Kp*alpha+Ki*int_alpha+Kd*dif_alpha;
    w = sign(w)*min(abs(w),wmax);
    diff_w = (w - w_old)/dt;
    
    dPdt = [v*cos(P(3));v*sin(P(3));w];
    
    P = P+dPdt*dt;
    P(3) = AjustaAngulo(P(3));
    
    R = [R,P];
   
    Erro = [Erro;abs(w) + abs(a*P(1) + b*P(2)+c)/sqrt(a^2 + b^2)];%abs(diff_w) <-- adicionar para calcular o trajeto suavizado 
    
    if isequal(plot_sim,1)
        PlotSimulaProcesso_foi;
        P_fin = P;
    end
end
    
    DeltaErro = mean(Erro);    
end