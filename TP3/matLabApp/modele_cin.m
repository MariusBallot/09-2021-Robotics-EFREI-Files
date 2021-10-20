function Jr=modele_cin(dh,val_arti);

% OBJET : programme de calcul du modele cinematique d'un robot
% Paramètres d'entrée : 
% *** dh tableau de n lignes et 5 colonnes, n étant le nombre d'axe du robot
% pour la ième lignes, les colonnes sont :
% colonne 1 : 0 si la liaison est rotoïde A pour une prismatique
% colonne 2 : a_{i-1} en mètres
% colonne 3 : alpha_{i-1} en radians
% colonne 4 : d_{i} en mètre si l'articulation est rotoide (0 sinon)
% colonne 5 : theta_{i} en radians si l'articulation est prismatique (0 sinon)
% *** val_arti : vecteur à n composantes contenant les valeurs instantannée
% des variables articulaires (en radians ou mètres, selon)
% Matrice retournée = Jacobienne exprimée au point On dans la base R0.
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
    
