%%-----------------------------------------------------%%
%%-----------------------------------------------------%%
% OBJET : Function allowing the 3D display of the Staubli
% RX90 robot in a given configuration

%Modification : 
%%-----------------------------------------------------%%
%%-----------------------------------------------------%%


%% Clean up the workspace and existing figures
clear all
close all
clc

%% Robot parameters

[L2,L3,L6,dh] = RX90data;

%qStraight = [0; -pi/2; pi/2; 0; 0; 0];

% Initial configuration
q0 = [0; 0; 0; 0; 0; 0];

% Set the current configuration
q = q0;
qGoal = q;

T = modele_geom(dh,q); 

EEpGoal = T(1:3,4);
EEoGoal = T(1:3,1:3);


%% Gui parameters and figure creation

% Figure creation
%scrsz = get(0,'ScreenSize');
figure
hold on;
numfig = gcf;

set(numfig,'Position',[1  1 1024 800],...
    'Name','RX90 3D view','toolbar','figure');

% "Go" button
Bgroup       =   uibuttongroup('Parent',numfig, ...
    'Units', 'normalized',...
    'Position',[0.0 0 0.06 0.05],...
    'Title',{''},...
    'BorderType', 'none');
h_Go    =   uicontrol('Parent',Bgroup,...
    'Units', 'normalized',...
    'Position',[0 0 1 1],...
    'String', 'Go',...
    'Callback',@GoCallback,'interruptible','off','busyaction','cancel');

% "IK Go" button
Bgroup       =   uibuttongroup('Parent',numfig, ...
    'Units', 'normalized',...
    'Position',[0.0 0.08 0.06 0.05],...
    'Title',{''},...
    'BorderType', 'none');
h_IKGo    =   uicontrol('Parent',Bgroup,...
    'Units', 'normalized',...
    'Position',[0 0 1 1],...
    'String', 'IK Go',...
    'Callback',@IKGoCallback,'interruptible','off','busyaction','cancel');

% "qGoal" fields
h_qGoalT = uicontrol('Parent',numfig,'style','text','Units','normalized','String','Goal Configuration:','Position',[0.08 0.01 0.13 0.03]);
h_qGoalF = uicontrol('Parent',numfig,'style','edit','Units','normalized','String',mat2str(q),'Position',[0.22 0.01 0.2 0.03],'Callback',@getQCallback);
set([h_qGoalT, h_qGoalF],'HorizontalAlignment','left');

% "EE Goal" fields
h_EEpGoalT = uicontrol('Parent',numfig,'style','text','Units','normalized','String','Goal EE Position:','Position',[0.08 0.11 0.13 0.03]);
h_EEpGoalF = uicontrol('Parent',numfig,'style','edit','Units','normalized','String',mat2str(EEpGoal,3),'Position',[0.22 0.11 0.12 0.03],'Callback',@getEEpCallback);

h_EEoGoalT = uicontrol('Parent',numfig,'style','text','Units','normalized','String','Goal EE Orientation:','Position',[0.08 0.07 0.13 0.03]);
h_EEoGoalF = uicontrol('Parent',numfig,'style','edit','Units','normalized','String',mat2str(EEoGoal,3),'Position',[0.22 0.07 0.25 0.03],'Callback',@getEEoCallback);
set([h_EEoGoalT, h_EEoGoalF, h_EEpGoalT, h_EEpGoalF],'HorizontalAlignment','left');

% Current config. and EE pose display
h_q = uicontrol('Parent',numfig,'style','text','Units','normalized','String','Current Configuration:','Position',[0.54 0.01 0.45 0.03]);
h_T = uicontrol('Parent',numfig,'style','text','Units','normalized','String','Current EE Pose :','Position',[0.8 0.1 0.19 0.15]);
set([h_q h_T],'HorizontalAlignment','left');

% 3D display subplot
grid on;
view(45,30);
axis(gca,'equal',[-1.0,1.0,-1.0,1.0,-1.0,1.0]);
hold on;

% Plot robots body
h = CorpsRX90();

% Update display
MvtRobot(dh,h,q);

% Update the display of the current config and current EE pose 
updateVal(q,h_q,T,h_T);