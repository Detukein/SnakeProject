
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

Data=importdata('.\Data\Horizontal1.csv');



%% Ce qu'on reçoit du capteur 

angle1=Data(:,1);%Theta
angle2=Data(:,2);%Phi
%% Données propres au capteur
n=1;
LCapteur = 100; %en mm
O = [0,0,0];


%% BOITE NOIRE 
nFrame = size (Data,1);

R=(LCapteur./(2*n*sind(angle1/(2*n))));




X = R.*(1-cosd(angle1)).*cosd(angle2);
Y = R.*(1-cosd(angle1)).*sind(angle2);
Z = R.*sind(angle1);


 for i = 1:nFrame
     
     plot3([0, X(i)],[0, Y(i)],[0, Z(i)],'-o');
     xlim([min(X),max(X)]);
     ylim([min(Y),max(Y)]);
     zlim([0,max(Z)]);
     drawnow
     pause(1/100)
 end


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
% plot3(0,0,0,'o', X,Y,Z,'-o') où '-o' permet de faire un trait entre O et K
%On peut rajouter des points en plus pour avoir le rayon de courbure approximatif
