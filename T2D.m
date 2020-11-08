function M2 = T2D(M1 , DeltaX , DeltaY)

T = [1 0 DeltaX
     0 1 DeltaY
     0 0 1];
 
 M2 = T*M1;
 
end