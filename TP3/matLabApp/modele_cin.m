function Jr=modele_cin(dh,val_arti);

% OBJET : programme de calcul du modele cinematique d'un robot
% Param�tres d'entr�e : 
% *** dh tableau de n lignes et 5 colonnes, n �tant le nombre d'axe du robot
% pour la i�me lignes, les colonnes sont :
% colonne 1 : 0 si la liaison est roto�de A pour une prismatique
% colonne 2 : a_{i-1} en m�tres
% colonne 3 : alpha_{i-1} en radians
% colonne 4 : d_{i} en m�tre si l'articulation est rotoide (0 sinon)
% colonne 5 : theta_{i} en radians si l'articulation est prismatique (0 sinon)
% *** val_arti : vecteur � n composantes contenant les valeurs instantann�e
% des variables articulaires (en radians ou m�tres, selon)
% Matrice retourn�e = Jacobienne exprim�e au point On dans la base R0.
nb_axes = length(val_arti);

J=zeros(6,nb_axes);

T0n = modele_geom(dh,val_arti);
for(i=1:nb_axes)
    %% Calcul de T0i
    T0i = modele_geom(dh(1:i,:),val_arti(1:i));
    J(1:3,i) = (1-dh(i))*T0i(1:3,3);
    J(4:6,i) = (1-dh(i))* cross( (T0i(1:3,4)-T0n(1:3,4)) , T0i(1:3,3) ) ...
        + dh(i) * T0i(1:3,3);
end

 Jr(1:3,:)=J(4:6,:);
 Jr(4:6,:)=J(1:3,:);
    
