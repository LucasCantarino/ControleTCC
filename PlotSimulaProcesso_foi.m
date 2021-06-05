RoboC = T2D(Rz2D(Corpo,P(3)),P(1),P(2)); %Corpo do robô;
RoboD = T2D(Rz2D(RodaD,P(3)),P(1),P(2));%Roda direita;
RoboE = T2D(Rz2D(RodaE,P(3)),P(1),P(2));%Roda esquerda;

plot([P_ini(1) G(1)],[P_ini(2) G(2)],'g','linewidth',2);hold on;
plot(G(1),G(2),'ok','linewidth',2,'markersize',8);

fill(RoboC(1,:),RoboC(2,:),'r')%Plot do Corpo do Robô
fill(RoboD(1,:),RoboD(2,:),'k')%Plot roda direita
fill(RoboE(1,:),RoboE(2,:),'k')%Plot roda esquerda

plot(R(1,:),R(2,:),'b','linewidth',2);hold on;%rastro do robô

plot([P(1) P(1)+0.1*cos(P(3))],[P(2) P(2)+0.1*sin(P(3))],'r','linewidth',2)%orientação atual do robô
plot([P(1) P(1)+1*cos(P(3)+pi/2)],[P(2) P(2)+1*sin(P(3)+pi/2)],'k','linewidth',2)%eixo das rodas: esquerdo
plot([P(1) P(1)+1*cos(P(3)-pi/2)],[P(2) P(2)+1*sin(P(3)-pi/2)],'k','linewidth',2)%eixo das rodas: direito
hold off;axis equal;grid on;xlabel('x');ylabel('y');set(gcf,'color','w');
title(sprintf('v = %.2fm/s t = %.2fs, Erro = %.2fm',v,t,Erro(end)));drawnow;