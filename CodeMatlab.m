clear all
clc 

% REPRESENTATION GRAPHIQUE

%% Utilisation du module BLE

%Connection avec le module bluetooth
device = ble("ads_eval_kit");
%a=characteristic(device,"ads_eval_kit","angles")
%Lire les informations du module BLE
angles = read(device,'latest');

