function [T]=modele_geom(dh,q);

%%-----------------------------------------------------%%
%%-----------------------------------------------------%%
%
% OBJECT :  Computes the forward kinematics model of 
%           a robot in configuration q and described by
%           modified dh parameters

%Modification : 
%%-----------------------------------------------------%%
%%-----------------------------------------------------%%

%% dh is a tab with n lines and 5 columns
% n is the number of dof of the robot
% For line i, columns are :
% 1 : type of dof (0 : revolute, 1 : prismatic)
% 2 : a_{i} in m
% 3 : alpha_{i} in rad
% 4 : d_{i} in m for a revolute joint, 0 otherwise
% 5 : theta_{i} in rad (dof for a revolute joint, constant otherwise)

ndof = size(dh,1);

if (length(q) == ndof) %% check compatibility
    T=eye(4);

    for (i=1:ndof)
        
        Tp = TH(q(i),dh(i,:));
        
        T = T*Tp;
    end

else
    disp('! Dimension mismatch between q and DH Le tableau de DH array !');
    T = zeros(4,4);
end
