clear all; clc; close all;

F0 = [1 0 0 0
      0 1 0 0
      0 0 1 0
      0 0 0 1];
  
DeltaX = 4;
DeltaY = 0;
DeltaZ = 0;

T =  [1 0 0 DeltaX
      0 1 0 DeltaY
      0 0 1 DeltaZ
      0 0 0 1];
  
F1 = T*F0;

PlotAparaB(F0,F1); hold on; PlotFrame(F0);PlotFrame(F1);hold off;
axis equal;grid on;xlabel('x');ylabel('y');zlabel('z');