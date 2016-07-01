%% Default Parameters
% Default parameters that are loaded initially with the model and can be
% changed with the GUI. All parameters are based on the MIT centrifuge
% system configuration running at 1G with an exercise protocol of 25W load,
% 50W load, 100W load. 
% Authors: Emma France, Ana Diaz Artiles
% Last update: 6/30/16

global Ex Exspin Ex_tau Pabd Pset Pset_tau  Rlc_fix wmax d Ex_0 Ex_25...
    Ex_50 Ex_100 Ex_spin Ex_tau_25 Ex_tau_50 Ex_tau_100 Pabd_0 Pabd_25 ...
    Pabd_50 Pabd_100 Pset_0 Pset_25 Pset_50 Pset_100 Pset_tau_end Pset_tau_25...
    Pset_tau_50 Pset_tau_100 Rlc_0 Rlc_25 Rlc_50 Rlc_100 Rlc_end...
    Teq Gain V_tot Tspinup Tspindown TotalSpinTime SimLength w_ang...
    A_cheb_09_1 B_cheb_09_1 C_cheb_09_1 ModelName GraphTrack


% The name of the .sim file to be used, for ease of change
ModelName = 'CV_Sys_Model_with_Exercise_4_4_16';
% A vector whose indices are 1 if that number graph has been selected and 0 if not
GraphTrack=zeros(1,13); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  SETUP   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d=[0 0];
V_tot=[0 5150];
Teq=[0 180];
Tspinup=[0 100];
Tspindown=[0 60];
TotalSpinTime=[0 1200];
SimLength=15*60+2*180+100+60; %~15 minutes exercise, plus spin and equilibration periods for spin up and spin down
Gain=[0 9];

% Baroreflex LPF Statespace Coefficients
A_cheb_09_1=[-9.45889157397485,-116.684730988048,-716.776540007884,...
-4286.18041417701,-16964.9739125645,-56703.9505500527,-128365.488100833,...
-200510.747016871,-151338.279894609;1,0,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0,0;...
0,0,1,0,0,0,0,0,0;0,0,0,1,0,0,0,0,0;0,0,0,0,1,0,0,0,0;0,0,0,0,0,1,0,0,0;...
0,0,0,0,0,0,1,0,0;0,0,0,0,0,0,0,1,0];
B_cheb_09_1=[1;0;0;0;0;0;0;0;0];
C_cheb_09_1=[0,0,0,0,0,0,0,0,151338.279894609];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% EXERCISE %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ex = [0 50 63 66];
    Exspin = 20;
    Ex_tau = [35 80 80];
    Pabd = [0 2.5 5 10];
    Pset = [95 120 140 220];
    Pset_tau = [30 80 70 20];
    w_ang = 28.6;
    Rlc_fix = [4.25 1.1 0.75 0.54 2.4];
    wmax=[0 28.6];
    
    Ex_0 = [0 Ex(1)];
    Ex_25 = [0 Ex(2)];
    Ex_50 = [0 Ex(3)];
    Ex_100 = [0 Ex(4)];
    Ex_spin = [0 Exspin];

    Ex_tau_25 = [0 Ex_tau(1)];
    Ex_tau_50 = [0 Ex_tau(2)];
    Ex_tau_100 = [0 Ex_tau(3)];

    Pabd_0 = [0 Pabd(1)];
    Pabd_25 = [0 Pabd(2)];
    Pabd_50 = [0 Pabd(3)];
    Pabd_100 = [0 Pabd(4)];

    Pset_0 = [0 Pset(1)];
    Pset_25 = [0 Pset(2)];
    Pset_50 = [0 Pset(3)];
    Pset_100 = [0 Pset(4)];

    Pset_tau_25 = [0 Pset_tau(1)];
    Pset_tau_50 = [0 Pset_tau(2)];
    Pset_tau_100 = [0 Pset_tau(3)];
    Pset_tau_end = [0 Pset_tau(4)];

    Rlc_0 = [0 Rlc_fix(1)];
    Rlc_25 = [0 Rlc_fix(2)];
    Rlc_50 = [0 Rlc_fix(3)];
    Rlc_100 = [0 Rlc_fix(4)];
    Rlc_end = [0 Rlc_fix(5)];