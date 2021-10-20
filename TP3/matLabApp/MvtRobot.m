
function[]=MvtRobot(dh,h,q)

%%-----------------------------------------------------%%
%%-----------------------------------------------------%%
% OBJECT :  Set the homogenous transform matrix of
%           objects pointed by h using the current robot
%           configuration and its DH description
%           

%Modification : 
%%-----------------------------------------------------%%
%%-----------------------------------------------------%%

for i=1:size(q,1)
  Hi=modele_geom(dh(1:i,:),q(1:i)); 
  set(h(i,1),'Matrix',Hi);
end;

