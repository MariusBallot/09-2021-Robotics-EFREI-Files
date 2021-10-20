function [L2,L3,L6,dh] = RX90data()

    % Adjustable body sizes
    L2 = 0.450; %m
    L3 = 0.450; %m
    L6 = 0.100; %m
    
    % Modified Denavit-Hartenberg tab
    % 1st col : Type of joint 0 : Revolute 1 : Prismatic
    % last col Initial_theta
    dh=[  0  0        -pi/2   0       0
          0  L2        0      0       0
          0  0        pi/2    0       0
          0  0        -pi/2   L3      0
          0  0        pi/2    0       0
          0  0        0       L6      0];

end
