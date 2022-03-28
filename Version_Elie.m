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

Data = importdata('.\Data\Cote30.csv');
% Data=[30,0];
%% Ce qu'on reçoit du capteur 

angle1 = Data(:,2)*pi/180;%Theta
angle2 = Data(:,1)*pi/180;%Phi
%% Données propres au capteur
n = 1;              %Nombre de points
LCapteur = 100;     %en mm
LC2 = LCapteur/2;
% O = [0,0,0];

%% BOITE NOIRE 
nFrame = size (Data,1);

X = sin(angle1)*(LC2);
Z = LC2*(1+cos(angle1));
Y = X.*sind(angle2);

LCordeCapteur = sqrt(X.^2+Z.^2);




for i=1:1:length(angle1)
    cla;
    
    %Angle max à un instant T
    Tm1 = atan2(X(i),Z(i));
    Tm2 = atan2(X(i),Y(i));

    %Calcul du rayon
%     R = LCapteur./(2*n*sin(Tm(i)./2*n));

%2D
%     R = LCapteur/(Tm1); 
%     Ri(i)=R;

%3D
    R1 = LCapteur/Tm1; 
    R2 = LCapteur/Tm2;
    % Calcul ensemble angles

    %Division du Théta utile
    if Tm1<0
        Tu1 = [0:-0.001:Tm1];
    else
        Tu1 = [0:0.001:Tm1];
    end

%     if Tm2<0
%         Tu2 = [0:-0.001:Tm2];
%     else
%         Tu2 = [0:0.001:Tm2];
%     end

    %Calucl des points en X et en Z pour chaques Tu
    Xp = R1.*(1-cos(Tu1));
    Zp = R1.*sin(Tu1);   
    Yp = R2.* sin(Tu1);

    Xef = R1.*(1-cos(Tm1));
    Zef = R1.*sin(Tm1);
    Yef = R2.* sin(Tm2);


%     plot(Xef,Zef,'k.'); 
%     hold on


%% Sorties 
%     Affichage  2D

    %axis("square")
    
    plot(Xp,Zp,'k.')
    xlim([-100,100]);
    ylim([-10,100]);
%     zlim([-100,200]);

%     %Affichage 3D
%     plot3(Xp,Zp, Yp,'k.')
%     xlim([-100,100]);
%     ylim([-10,100]);
%     zlim([-100,200]);
    drawnow
    pause(1/100)
end

% Xp = R.*(1-cosd(Tu));
% Zp = R.*sind(Tu);



%Utiliser la fonction trace pour avoir une mise en cache de la figure
% plot3(0,0,0,'o', X,Y,Z,'-o') où '-o' permet de faire un trait entre O et K
%On peut rajouter des points en plus pour avoir le rayon de courbure approximatif
% 

%% Test
% % Longueur de la corde
% LCordeCapteur = sqrt(X.^2+Z.^2);
% figure 
% plot(CordeLCapteur)
% grid on;
% xlabel('temps(s)');
% ylabel('Longueur de la corde du capteur');
% title('Evolution de la longueur de la corde du capteur au cours du temps');
% 
