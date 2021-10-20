function[h]=CorpsRX90()

%%-----------------------------------------------------%%
%%-----------------------------------------------------%%
% OBJET : Script qui permet de mettre en place les corps
% du robot St?ubli TX40 pour l'animation du robot

%%-----------------------------------------------------%%
%%-----------------------------------------------------%%


%%-----------------------------------------------------%%
%%      Mise en place de la figure et des corps
%%-----------------------------------------------------%%

%% Adjustable body sizes
[L2,L3,L6,dh] = RX90data();
L0 = 0.910; %m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MISE EN PLACE DE LA FIGURE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORPS ZERO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h0 = hgtransform();
c0=draw_cylinder(makehgtform('translate',[0 0 -0.09-L0/2]),0.08,L0);
set(c0,'Parent',h0,'FaceColor',[0.5 0.5 0.5]); %% attribue h0 comme parent et gris comme couleur
l01=line([0 0.25],[0 0],[0 0]); %% dessine un ligne symbolisant l'axe x_E
set(l01,'Parent',h0,'LineWidth',3,'Color','r'); %%attribue h0 comme parent et rouge comme couleur
t01=text(0.255,0,0,'x_0'); %% Ecrit x_E en bout d'axe
set(t01,'Parent',h0,'FontSize',12,'Color','r'); %%attribue h0 comme parent et rouge comme couleur
l02=line([0 0],[0 0.25],[0 0]); %% dessine un ligne symbolisant l'axe x_E
set(l02,'Parent',h0,'LineWidth',3,'Color','g'); %%attribue h0 comme parent et vert comme couleur
t02=text(0,0.255,0,'y_0'); %% Ecrit x_E en bout d'axe
set(t02,'Parent',h0,'FontSize',12,'Color','g'); %%attribue h0 comme parent et vert comme couleur
l03=line([0 0],[0 0],[0 0.25]); %% dessine un ligne symbolisant l'axe x_E
set(l03,'Parent',h0,'LineWidth',3,'Color','b'); %%attribue h0 comme parent et bleu comme couleur
t03=text(0,0,0.255,'z_0'); %% Ecrit x_E en bout d'axe
set(t03,'Parent',h0,'FontSize',12,'Color','b'); %%attribue h0 comme parent et bleu comme couleur

hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORPS UN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h1 = hgtransform();
p1=draw_parallelepiped(eye(4),0.18);
set(p1,'Parent',h1,'FaceColor','r'); %% attribue h1 comme parent et rouge comme couleur
c1=draw_cylinder(makehgtform('translate',[0 0 0.105]),0.08,0.03);
set(c1,'Parent',h1,'FaceColor','r'); %% attribue h1 comme parent et rouge comme couleur

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORPS DEUX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h2 = hgtransform();
c21=draw_cylinder(makehgtform('translate',[-L2 0 0.160]),0.06,0.08);
set(c21,'Parent',h2,'FaceColor','b'); %% attribue h2 comme parent et bleu comme couleur
c22=draw_cylinder(makehgtform('translate',[0 0 0.145]),0.06,0.11);
set(c22,'Parent',h2,'FaceColor','b'); %% attribue h2 comme parent et bleu comme couleur
p2=draw_parallelepiped(makehgtform('translate',[-L2/2 0 0.160]),[L2 0.12, 0.08]);
set(p2,'Parent',h2,'FaceColor','b'); %% attribue h2 comme parent et rouge comme couleur

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORPS TROIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h3 = hgtransform();
c31=draw_cylinder(makehgtform('translate',[0 0.03 0.0],'xrotate',pi/2),0.05,0.12);
set(c31,'Parent',h3,'FaceColor','y'); %% attribue h1 comme parent et rouge comme couleur
p3=draw_parallelepiped(makehgtform('translate',[0 0 L3/2-0.025]),[0.10 0.06 L3-0.05]);
set(p3,'Parent',h3,'FaceColor','y'); %% attribue h3 comme parent et jaune comme couleur
c32=draw_cylinder(makehgtform('translate',[0 0.0 L3-0.05],'xrotate',pi/2),0.05,0.06);
set(c32,'Parent',h3,'FaceColor','y'); %% attribue h1 comme parent et rouge comme couleur

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORPS QUATRE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h4 = hgtransform();
c4=draw_cylinder(makehgtform('translate',[0 0.015 0],'xrotate',pi/2),0.0275,0.03);
set(c4,'Parent',h4,'FaceColor','g'); %% attribue h4 comme parent et vert comme couleur

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORPS CINQ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h5 = hgtransform();
c5=draw_cylinder(makehgtform('translate',[0 0 0],'xrotate',pi/2),0.015,0.045);
set(c5,'Parent',h5,'FaceColor','m'); %% attribue h5 comme parent et magenta comme couleur

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORPS SIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 h6 = hgtransform();
 c6=draw_cylinder(makehgtform('translate',[0 0 -L6/2]),0.01,L6);
 set(c6,'Parent',h6,'FaceColor','c'); %%attribue h6 comme parent et cyan comme couleur
 l61=line([0 0.1],[0 0],[0 0]); %% dessine un ligne symbolisant l'axe x_E
 set(l61,'Parent',h6,'LineWidth',3,'Color','r'); %%attribue h6 comme parent et rouge comme couleur
 t61=text(0.105,0,0,'x_E'); %% Ecrit x_E en bout d'axe
 set(t61,'Parent',h6,'FontSize',12,'Color','r'); %%attribue h6 comme parent et rouge comme couleur
 l62=line([0 0],[0 0.1],[0 0]); %% dessine un ligne symbolisant l'axe x_E
 set(l62,'Parent',h6,'LineWidth',3,'Color','g'); %%attribue h6 comme parent et vert comme couleur
 t62=text(0,0.105,0,'y_E'); %% Ecrit x_E en bout d'axe
 set(t62,'Parent',h6,'FontSize',12,'Color','g'); %%attribue h6 comme parent et vert comme couleur
 l63=line([0 0],[0 0],[0 0.1]); %% dessine un ligne symbolisant l'axe x_E
 set(l63,'Parent',h6,'LineWidth',3,'Color','b'); %%attribue h6 comme parent et bleu comme couleur
 t63=text(0,0,0.105,'z_E'); %% Ecrit x_E en bout d'axe
 set(t63,'Parent',h6,'FontSize',12,'Color','b'); %%attribue h6 comme parent et bleu comme couleur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sortie de la fonction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h(1,1)=h1;
h(2,1)=h2;
h(3,1)=h3;
h(4,1)=h4;
h(5,1)=h5;
h(6,1)=h6;

