function [conf] = IK_RX90(p, R, q_k)

% p : End-effector position
% R : End-effector orientation
% q_k : Current configuration

% There are n solutions to the IK of an RX90
% We will store them in nx6 array (one solution per line)

% Get RX90 data (length and DH params)
[L2, L3, L6, dh] = RX90data;

%%% Temporary %%%
n = 1;
q = zeros(n, 6);
k = 1;
%%% End temporary %%%

%%% Your code %%%
p4 = p - R * [0; 0; L6];

% Theta1 setup
theta1 = atan2(p4(2), p4(1));
q(1:4, 1) = theta1;
q(5:8, 1) = theta1 + pi;

% Theta2 setup
for(i = 1 : 8)

lambda(i) = p4(1) * cos(q(i, 1)) + p4(2) * sin(q(i, 1));
B = - 2 * L2 * lambda(i);
A = 2 * p4(3) * L2;
C = L3 * L3 - p4(3) * p4(3) - L2 * L2 - lambda(i) * lambda(i)

eps = (- 1) ^ i;

inter = sqrt(A * A + B * B - C * C);
q(i, 2) = atan2(A * C - eps * B * inter, B * C + eps * A * inter);
q(i, 3) = atan2(- p4(3) * sin(q(i, 2)) + lambda(i) * cos(q(i, 2))-L2, lambda(i) * sin(q(i, 2)));
end


%Pre-call Theta4, 5, 6
T06(1:3, 1:3) = R;
T06(1:3, 4) = p;
T06(4, :) = [0 0 0 1];

%computing des Solutions de 1 a 6 
i = 1;
while (i < 7)
    TH01 = TH(q(i, 1), dh(1, :));
    TH12 = TH(q(i, 2), dh(2, :));
    TH23 = TH(q(i, 3), dh(3, :));
    T = inv(TH01 * TH12 * TH23)*T06;
    
    
    % Cacules de theta5 and theta4
    q(i,5) = atan2(sqrt(T(1,3)*T(1,3)+T(2,3)*T(2,3)),T(3,3));
 
    if (sin(q(i, 5)) == 0)
        q(i, 4) = q_k(4);
    else
        q(i, 4) = atan2(T(2, 4), T(1, 4));
    end
    
    % pour theta6
    TH34 = TH(q(i, 4), dh(4, :));
    TH45 = TH(q(i, 5), dh(5, :));
    V = inv(TH34 * TH45) * T;
 
    q(i, 6) = atan2(V(2, 1), V(1, 1));
    if (i == 2)
        i = 5;
    else
        i = i + 1;
    end
end

i = 3;
while (i < 9)
 
    a(i, 4) = q(i - 2, 4) + pi;
    qa(i, 5) = - q(i - 2, 5);
    qa(i, 6) = q(i - 2, 6) + pi;
 
    if (i == 4)
        i = 7;
    else
        i = i+1;
    end
 
end

q = mod (q, 2*pi);
for(i=1:8)
   for(j=1:6)
        if(abs (q(i,j)) > pi)
            q(i,j) = q(i,j) - 2*sign (q(i,j))*pi; 
        end
    end
end

%Algo de chois de la meilleur config
%Avec k l'index de la config dans q, le set des différentes configs

qmiddle = [0;-pi/2;pi/2;0;0;0];
norme_min = inf;
for(i=2:8)
    norme = norm(qmiddle-q(i,:));
    if(norme < norme_min)
        norme_min = norme;
        k = i;
    end
end

%%% End of your code %%%

conf = q(k, :)';
disp(q);

end