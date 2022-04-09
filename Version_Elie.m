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

Data = importdata('.\Data\TEST2.csv');

%% Ce qu'on reçoit du capteur 

angle1 = Data(:,2)*pi/180;%Theta
angle2 = Data(:,1)*pi/180;%Phi

%% Données propres au capteur

LCapteur = 100;     %en mm
LC2 = LCapteur/2;

%% BOITE NOIRE 

% Calcul du Z et du X avec l'angle 1

X = LC2*sin(angle1);
Z = LC2*(1+cos(angle1));

% Si X est négatif, sela change le signe de Y, d'ou l'utilisation d'une valeur absolue pour X

Y = abs(X).*tan(angle2);

% if X<0
%     Y = abs(X).*tan(angle2);
% else 
%     Y = X.*tan(angle2);
% end



for i=1:1:length(angle1)
%     cla;
    
% Angle maximal à chaque instant

    a1 = atan2(X(i),Z(i));
    a2 = atan2(Y(i),Z(i));


% Calcul du rayon

    R1 = LCapteur/a1; 
    R2 = LCapteur/a2;

% Division du Théta utile (Tu)

%     tic
    u = 0.007; 

    if a1<0
        au1 = [0:-u:a1];
    else
        au1 = [0:u:a1];
    end

% La taille de Tu1 doit etre identique à celle de Tu2

    Ti=(u*a2)/a1;
    
    if a2<0
        au2 = [0:-Ti:a2];
    else
        au2 = [0:Ti:a2];
    end
    

% Calcul des points X,Y et Z             (Tu)

    Xp = R1.*(1-cos(au1));
    Zp = R2.*sin(au2);   
    Yp = R2.*(1-cos(au2));
    
%     toc

% Calul du point final en X,Y et Z       (Tm)

    Xef = R1.*(1-cos(a1));
    Zef = R2.*sin(a2);
    Yef = R2.*(1-cos(a2));

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

    plot3(Xp,Yp,Zp,'k.');
%     hold on 
    xlim([-100,100]);
    ylim([-100,100]);
    zlim([-10,100]);

   
    grid on
    
    xlabel('Vertical du capteur')
    ylabel('Latéral du capteur')
    zlabel('Hauteur du capteur')
    title('Représentation des déplacements du capteur')

    drawnow
    pause(1/200)
end
