%%%%%%%%%%% Automating CST using MATLAB from MatCST Toolbox %%%%%%%%%%%%%%%%%%%%%%%%
This file demonstrates the use of the MatCST toolbox for eigenmode solver and for deeper udnerstanding of
the CST eigenmode sover user is requested to go through the CST STUDIO help manual.
The example here is similar to the example given in the CST STUDIO SUITE Help.
You can find the example in the CST STUDIO SUITE help at
Tutorials and Examples\CST MWS Example\Eigenmode Analysis Examples\Cylinder Resonator.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
General Description

Aim: This example demonstrates how to use MatCST for eigenmode analysis. You will learn how to
open cst file, change the parameter values, eigenmode settings,and start the solver. Once the
solver finishes, eigenfrequencies, power loss, quality factor and electric and magnetic field values
of the modes are demonstrated.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Setting up the files

Install the MatCST toolbox package first. Then download and save the the cylindricalCavityControl.m and
cylindricalCavity.cst files availabe in this folder. Then, open the cylindricalCavityControl.m (matlab file)
in matlab and assign the path of the folder of cylindricalCavity.cst  to the matlab variable 'pathFile'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Strcuture generation

In this example, length and radius of the cavity is fixed to 0.4m and 0.15m as given in the original example.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pre-processing
No symmetric boudnary condition is set and users are encouraged to try to use symmetric boudnary condtion.

Boudnary conditions are set to 'electric' in all directions i.e in order to have a perfect conducting walls.

Frequency range is set to 500e6 Hz (fmin) to 800e6 Hz (fmax)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Solver setup

In this example tetrahedral mesh is used and 5 modes are calculated by specifying the solver to calculate modes
above 500e6 Hz.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Post processing

By selectign the mode/s, the eigenfrequencie/s of the mdoe/s can be extracted from CST to MATLALB.
Further, power loss and Quality factors can be imported to MATLAB from CST. Finally, Ez and Hz of mode 3
are plotted and from this we can know that it is a TM mode. Further, Ez values are used to find r/Q.
The r/Q calculated from extracting the field vlaues and obtained directly from CST can also be compared.



