
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
% Data=[30,0];
%% Ce qu'on reçoit du capteur 

angle1=Data(:,1);%Theta
angle2=Data(:,2);%Phi
%% Données propres au capteur
n=1;                %Nombre de points
LCapteur = 100;     %en mm
LC2=LCapteur/2;
O = [0,0,0];


%% BOITE NOIRE 
nFrame = size (Data,1);

%Initialisation des matrices 
Xm=zeros([nFrame, 1]);
Ym=zeros([nFrame, 1]);
Zm=zeros([nFrame, 1]);
CordeCapteur=zeros([nFrame, 1]);

%Point Final 
X = sind(angle1).*(LC2);
Y = LC2.*(1+cosd(angle1));
Z = X.*sind(angle2);

%Point milieu de la corde
XPm = LC2/2.*sind(angle1);
YPm = (LC2/2)+cosd(angle1)*LC2/2;
ZPm = XPm.*sind(angle2);

%Point milieu courbe 
alpha = 180-(90+(180-angle1)/2);
gamma = 90-alpha;
fleche1 = angle1/6;
% for i = 1:nFrame
%     CordeCapteur(i,1) = sqrt(X(i,:)^2+Y(i,:)^2+Z(i,:)^2);
%     Xm(i,1) = (CordeCapteur(i,1)./2).*cosd(gamma(i,1))-fleche.*sind(gamma(i,1));
%     Ym(i,1) = (CordeCapteur(i,1)./2).*sind(gamma(i,1))-fleche.*cosd(gamma(i,1));
%     Zm(i,1) = XPm.*sind(angle2(i,1));
% end 

CordeCapteur = sqrt(X.^2+Y.^2+Z.^2);
a=CordeCapteur./2;
fleche2=angle2./6;
Xm = (CordeCapteur./2).*cosd(gamma)-fleche1.*sind(gamma);
Ym = (CordeCapteur./2).*sind(gamma)-fleche1.*cosd(gamma);
Zm = -a.*sind(angle2)+fleche2.*cosd(angle2);
%% Sorties 

 for i = 1:nFrame
     
     plot3([0, Xm(i), X(i)],[0, Ym(i), Y(i)],[0, Zm(i), Z(i)],'-o');
%     plot3([0, X(i)],[0, Y(i)],[0, Z(i)],'-o');
     xlim([-100,max(X)]);
     ylim([-100,max(Y)]);
     zlim([-100,max(Z)]);
     drawnow
     pause(1/100)
 end

%Utiliser la fonction trace pour avoir une mise en cache de la figure
% plot3(0,0,0,'o', X,Y,Z,'-o') où '-o' permet de faire un trait entre O et K
%On peut rajouter des points en plus pour avoir le rayon de courbure approximatif

%% Test
% Longueur de la corde

% figure 
% plot(CordeLCapteur)
% grid on;
% xlabel('temps(s)');
% ylabel('Longueur de la corde du capteur');
% title('Evolution de la longueur de la corde du capteur au cours du temps');

