function [T] = TH(q,dh)

%% dh is a line 5 columns
% 1 : type of dof (0 : revolute, 1 : prismatic)
% 2 : a_{i} in m
% 3 : alpha_{i} in rad
% 4 : d_{i} in m for a revolute joint, 0 otherwise
% 5 : theta_{i} in rad (dof for a revolute joint, constant otherwise)


a=dh(2);
alpha=dh(3);

if(dh(1) == 0) %% revolute joint
    theta = q;
    d  = dh(4);
else
    theta = dh(5);
    d = q;
end
   
T = [cos(theta)     -sin(theta)*cos(alpha)  sin(theta)*sin(alpha)   a*cos(theta)
     sin(theta)     cos(theta)*cos(alpha)   -cos(theta)*sin(alpha)  a*sin(theta)
     0              sin(alpha)              cos(alpha)              d
     0              0                       0                       1];

end