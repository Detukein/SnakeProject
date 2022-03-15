
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

Data=importdata('.\Data\Alea.csv');
% Data=[45,0;0,0;0,0;0,0;0,0;0,0;0,0];
%% Ce qu'on reçoit du capteur 

angle1=Data(:,1);%Theta
angle2=Data(:,2);%Phi
%% Données propres au capteur
n=1;
LCapteur = 100; %en mm
LC2=LCapteur/2;
O = [0,0,0];


%% BOITE NOIRE 
nFrame = size (Data,1);
aT=pi/2-angle1;
X = sind(aT).*(LC2);
Y = LC2.*(1+cosd(aT));
Z = X.*sind(angle2);

E=[X,Y,Z];
J=transpose(E)*E;
S=transpose(E)*Data;
X=J^-1*S;
A=X(1,1);
B=X(2,1);
C=X(3,1);

% SOLUTION = A.*X+B.*Y+C.*Z;


%% Sorties 

%  for i = 1:nFrame
%      
%      plot3([0, X(i)],[0, Y(i)],[0, Z(i)],'-o');
%      xlim([-100,max(X)]);
%      ylim([-100,max(Y)]);
%      zlim([-100,max(Z)]);
%      drawnow
%      pause(1/100)
%  end

%Utiliser la fonction trace pour avoir une mise en cache de la figure
% plot3(0,0,0,'o', X,Y,Z,'-o') où '-o' permet de faire un trait entre O et K
%On peut rajouter des points en plus pour avoir le rayon de courbure approximatif

%% Test
% Longueur de la corde
% for i = 1:nFrame
%     VerifLCapteur(i,1) = (sqrt(X(i,:)^2+Y(i,:)^2+Z(i,:)^2));
% end 
% 
% figure 
% plot(VerifLCapteur)
% grid on;
% xlabel('temps(s)');
% ylabel('Longueur de la corde du capteur');
% title('Evolution de la longueur de la corde du capteur au cours du temps');