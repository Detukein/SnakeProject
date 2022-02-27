
clear all
clc 

%% Connection avec module

%Connection avec le module bluetooth
Capteur = ble("ads_eval_kit");

Angle=characteristic(Capteur,"Battery Service","Battery Level")
disp(Angle)
% Angle.DataAvailableFcn=@callback;
subscribe(Angle)
% unsubscribe (Angle);
[Angle1,Angle2] = read (Angle,'oldest')


function callback(src,evt);
    [Angle1,Angle2] = read (src,'oldest');
    disp (Angle1)
    disp (Angle2)
end

%C=Angles

% Angles=[30,45];

%% Ce qu'on reçoit du capteur 
% 
% AngleVer = Angles (1,1);
% AngleHor = Angles (1,2);
%% Données propres au capteur

% LCapteur = 100; %en mm
% 
% O = [0,0,0]


%% BOITE NOIRE 

% rV = abs ((180*LCapteur)/pi*AngleVer)
% rH = abs ((180*LCapteur)/pi*AngleHor)
% 
% function K = PointFinal (rV,rH)
% K = [rV,rH,JSP]
% 
% %K dépend du rayon de courbure du capteur en vertical et en horizontal(X et Y). 
% %Il ne nous reste plus qu'à calculer la fin du capteur (en Z) 
% end


%% Sorties 

%Utiliser la fonction trace pour avoir une mise en cache de la figure
% plot3(0,0,0,'o', xK,yK,zK,'-o') où '-o' permet de faire un trait entre O et K
%On peut rajouter des points en plus pour avoir le rayon de courbure approximatif
