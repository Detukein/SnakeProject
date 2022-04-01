close all
clear all
clc 

%% Connection avec module

%Connection avec le module bluetooth
% Capteur = ble("ads_eval_kit");
% 
% Angle=characteristic(Capteur,"Battery Service","Battery Level")
% disp(Angle)
% % Angle.DataAvailableFcn=@callback;
% subscribe(Angle)
% % unsubscribe (Angle);
% [Angle1,Angle2] = read (Angle,'oldest')
% 
% 
% function callback(src,evt);
%     [Angle1,Angle2] = read (src,'oldest');
%     disp (Angle1)
%     disp (Angle2)
% end
% 
%C=Angles

Data = importdata('.\Data\TEST45.csv');
% Data=[30,0];
%% Ce qu'on reçoit du capteur 

angle1 = Data(:,2)*pi/180;%Theta
angle2 = Data(:,1)*pi/180;%Phi
angle3 = [-360:1:360];

tan3=tand(angle3);
plot(tan3)
%% Données propres au capteur
n = 1;              %Nombre de points
LCapteur = 100;     %en mm
LC2 = LCapteur/2;
% O = [0,0,0];

%% BOITE NOIRE 
nFrame = size (Data,1);

Z = LC2*(1+cos(angle1));
X = sin(angle1)*(LC2);
Y = X.*tan(angle2);

LCordeCapteur = sqrt(X.^2+Z.^2);

Tm1 = atan2(X,Z);
Tm2 = atan2(Y,Z);


% figure 
% plot(angle2)
% figure
% plot(Tm1);hold on
% plot(Tm2)

%% 
%Pourquoi notre valeur de Tm2 ne marche pas ? 
