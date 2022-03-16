
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
alpha = 180-(90+(180-angle1)/2);
gamma = 90-alpha;

%Initialisation des matrices 
Xm=zeros([nFrame, 1]);
Ym=zeros([nFrame, 1]);
Zm=zeros([nFrame, 1]);
CordeCapteur=zeros([nFrame, 1]);

%Point Final (5) 
X = sind(angle1).*(LC2);
Y = LC2.*(1+cosd(angle1));
Z = X.*sind(angle2);

% %Point milieu de la corde
% XPm = LC2/2.*sind(angle1);
% YPm = (LC2/2)+cosd(angle1)*LC2/2;
% ZPm = XPm.*sind(angle2);

%Point milieu courbe (3)
flechem1 = angle1/6;
flechem2=angle2./6;

CordeCapteur = sqrt(X.^2+Y.^2+Z.^2);
a=CordeCapteur./2;

Xm = (CordeCapteur./2).*cosd(gamma)-flechem1.*sind(gamma);
Ym = (CordeCapteur./2).*sind(gamma)-flechem1.*cosd(gamma);
Zm = -a.*sind(angle2)+flechem2.*cosd(angle2);

%Point de la courbe (2)
fleche21 = angle1./8-(0.25*CordeCapteur).^2./CordeCapteur.^3.*2/3.*angle1;
fleche22 = angle2./8-(0.25*CordeCapteur).^2./CordeCapteur.^3.*2/3.*angle2;

X2 = (CordeCapteur./4).*cosd(gamma)-fleche21.*sind(gamma);
Y2 = (CordeCapteur./4).*sind(gamma)-fleche21.*cosd(gamma);
Z2 = -a./2.*sind(angle2)+fleche22.*cosd(angle2);


%Point de la courbe (4)
fleche41 = 3.*angle1./8-(2.*angle1)./(3.*CordeCapteur.^3).*(3/4.*CordeCapteur).^3;
fleche42 = 3.*angle2./8-(2.*angle2)./(3.*CordeCapteur.^3).*(3/4.*CordeCapteur).^3;

X4 = (CordeCapteur./4).*cosd(gamma)-fleche41.*sind(gamma);
Y4 = (CordeCapteur./4).*sind(gamma)-fleche41.*cosd(gamma);
Z4 = -a./2.*sind(angle2)+fleche42.*cosd(angle2);
%% Sorties 

 for i = 1:nFrame
     
     %plot3([0, X2(i), Xm(i), X4(i), X(i)],[0, Y2(i), Ym(i), Y4(i), Y(i)],[0, Z2(i), Zm(i), Z4(i), Z(i)],'-o');
     plot3([0, Xm(i), X(i)],[0, Ym(i), Y(i)],[0, Zm(i), Z(i)],'-o');
     xlim([-100,100]);
     ylim([-100,100]);
     zlim([-100,100]);
     drawnow
     pause(1/100)
 end

%Utiliser la fonction trace pour avoir une mise en cache de la figure
% plot3(0,0,0,'o', X,Y,Z,'-o') où '-o' permet de faire un trait entre O et K
%On peut rajouter des points en plus pour avoir le rayon de courbure approximatif

%% Test
% Longueur de la corde
LCordeCapteur = sqrt((X-X4).^2+(Y-Y4).^2+(Z-Z4).^2)+sqrt((X4-Xm).^2+(Y4-Ym).^2+(Z4-Zm).^2)+sqrt((Xm-X2).^2+(Ym-Y2).^2+(Zm-Z2).^2)+sqrt((X2).^2+(Y2).^2+(Z2).^2);
figure 
plot(CordeLCapteur)
grid on;
xlabel('temps(s)');
ylabel('Longueur de la corde du capteur');
title('Evolution de la longueur de la corde du capteur au cours du temps');

