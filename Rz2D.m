function M2 = Rz2D(M1 , th)

Rz = [cos(th) -sin(th) 0
      sin(th)  cos(th) 0
      0        0       1];
  
  M2 = Rz*M1;
  
  end
  