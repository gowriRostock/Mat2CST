%% This is a sample matlab script to demonstrate the working of the MatCST package
% Please go through the readme.txt before going through thsi script
% First please provide the path of the folder where cylindricalCavity.cst
% is located to the variable 'pathFile'

%% Initializations
clear all
clc
eo=8.854187e-12;mu=4*pi*1e-7;
zeta=sqrt(mu/eo);
c=1/sqrt(mu*eo);
%% Open the CST file
% First please provide the path of the folder where cylindricalCavity.cst
% is located to the variable 'pathFile'
pathFile='D:\Gowrishankar\MatlabControlsCST\';% path to cst file
fileName='cylindricalCavity'; %cst file name
[cst,mws]=OpenCST(strcat(pathFile,fileName,'.cst'),2017);

%% modify the parameters
lengthCavity=0.4;
radiusCavity=0.15;
StoreParameter(mws,2,'lengthCavity',lengthCavity,'radiusCavity',radiusCavity); 

%% SymmetryPlane testing
SimulationSymmetryPlane(mws,'none','none','none');

%% Boundary condition
SimulationBoundaries(mws,'True','electric');

%% Simulation frequency range settings
SimulationFrequencySettings(mws,500e6,800e6);

%% Eigenmode solver settings
EigenmodeSolverSetting(mws,'Tetra',3,500e6);

%% Eigenmode start
EigenmodeSolverStart(mws);

%% EigenFrequency
eigenFre=EigenFrequency(mws,'1-4'); % Gives eigenfrequency of mode2 mode8
%eigenFre=EigenFrequency(mws,1); % Gives eigenfrequency of mode7
%eigenFre=EigenFrequency(mws,'All'); % Gives eigenfrequency of all the calculated modes
%% Loss and Q calculation
[L,Q]=LossAndQ(mws,3,'Copper',58.5e6); %Gives power loss and Quality factor of Mode8
%[L,Q]=LossAndQ(mws,'05-9','Copper',58.5e6); %Gives power loss and Quality factor of Mode05 to Mode 09
%[L,Q]=LossAndQ(mws,'All','Copper',58.5e6); %Gives power loss and Quality of the modes calcualted
%% Field values along the z-axis of the cavity
[ex,ey,ez,hx,hy,hz,position]=FieldValues(mws,'Z',-lengthCavity/2,lengthCavity/2,0,0,1200,3);

%% Close CST file
CloseFile(mws,'True')  % First saves the results and closes the cst file which was opened

%% Close entire cst windows
CloseCST(cst)
% % resulttemp=invoke(mws,'TemplateBasedPostprocessing')
% % invoke(resulttemp,'Evaluate All')