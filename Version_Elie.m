close all
clear all
clc 

%% Connection avec module ou récupération des données 

%Connection avec le module bluetooth
% 
% Capteur = ble("ads_eval_kit");
% 
%Récupération de l'emplacement des données transmises par le capteur
% 
% Angle=characteristic(Capteur,"Battery Service","Battery Level")
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

Data = importdata('.\Data\Horizontal1.csv');

%% Ce qu'on reçoit du capteur 

angle1 = Data(:,2)*pi/180;%Theta
angle2 = Data(:,1)*pi/180;%Phi

%% Données propres au capteur

LCapteur = 100;     %en mm
LC2 = LCapteur/2;

%% BOITE NOIRE 

%Calcul du Z et du X avec l'angle 1

Z = LC2*(1+cos(angle1));
X = sin(angle1)*(LC2);

% Si X est négatif, sela change le signe de Y, d'ou l'utilisation d'une
% valeur absolue

Y = abs(X).*tan(angle2);

% if X<0
%     Y = abs(X).*tan(angle2);
% else 
%     Y = X.*tan(angle2);
% end



for i=1:1:length(angle1)
%     cla;
    
% Angle maximal à chaque instant

    Tm1 = atan2(X(i),Z(i));
    Tm2 = atan2(Y(i),Z(i));


% Calcul du rayon

    R1 = LCapteur/Tm1; 
    R2 = LCapteur/Tm2;

% Division du Théta utile (Tu)
    

    if Tm1<0
        Tu1 = [0:-0.0000001:Tm1];
    else
        Tu1 = [0:0.0000001:Tm1];
    end

% La taille de Tu1 doit etre identique à celle de Tu2

    Ti=(0.0000001*Tm2)/Tm1;
    if Tm2<0
        Tu2 = [0:-Ti:Tm2];
    else
        Tu2 = [0:Ti:Tm2];
    end


% Calcul des points X,Y et Z             (Tu)

    Xp = R1.*(1-cos(Tu1));
    Zp = R2.*sin(Tu2);   
    Yp = R2.*(1-cos(Tu2));
    
% Calul du point final en X,Y et Z       (Tm)

    Xef = R1.*(1-cos(Tm1));
    Zef = R2.*sin(Tm2);
    Yef = R2.* (1-cos(Tm2));

%% Sorties 

%     Affichage  2D
    
%     plot(Xp,Yp,'k.')
%     xlim([-100,100]);
%     ylim([-10,100]);

%     plot(Yef,Zef,'g.')
%     plot(Xef,Zef,'r.')

%     plot(Xp,Zp,'m.')
%     plot(Yp,Zp,'b.')
%     xlim([-100,100]);
%     ylim([-10,100]);


%     plot(Y,'r.'); 
%     plot(X,'g.')

%     Affichage 3D

    plot3(Xp,Yp,Zp,'k.')
    xlim([-100,100]);
    ylim([-100,100]);
    zlim([-10,100]);

   
    grid on
    
    xlabel('Vertical du capteur')
    ylabel('latéral du capteur')
    zlabel('Hauteur du capteur')
    title('Représentation des déplacements du capteur')

    drawnow
    pause(1/200)
end
