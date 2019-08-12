# Mat2CST
<p align="center"> 
<img src="https://github.com/gowriRostock/Mat2CST/blob/master/logoMat2CST.png">
</p>

CST STUDIO SUITE &reg; [1] is a powerful electromagnetic simulation software which has recently been updated with Multiphysics solvers to do coupled problem analysis. MATLAB &reg; [2] is ubiquitous in scientific research and analysis because of large user base, easy to program, and avaailability of many open source toolboxes. Functionality of CST can be increased many fold by itegrating with MATLAB. Mat2CST is a MATLAB toolbox developed to automate the CST, i.e. to control CST directly from MATLAB without using any intermediate VBA bas files. CST has many different solvers and currently Mat2CST can be used to control most of the features of **eigenmode solver**. In future, it is planned to include other solvers with the help of collaborators. If you are interested in collaborating and contributing to this project, please contact : gowrishankar.hallilingaiah2@uni-rostock.de 

## Software and the compatible versions
Foloowing softwares and versions are supported by this toolbox. 
* MATLAB 2017A
* CST STUDIO 2017

**Note**: There is no gaurantee that the Mat2CST toolbox would work in lower or higher versions. However, usually with little modification to Mat2CST it can be adopted to work with other versions.

## Installing the toolbox
To use the Mat2CST toolbox, you can simply download the code and place the code in a folder where MATLAB searches for the functions. Otherwise, you can use the below link to visit the "file exchange" where you can use the dropdown menu to select download from "github" and donwload the toolbox. Open the toolbox, install it and you are ready to go.

## Tutorial
It is always better to understand a code with an example. In this case, a simple cylindrical resonator example is considered to demonstrate the Mat2CST toolbox functionalities. This example is given in CST help. Toolbox users are encouraged to first try the tutorial files before going for the actual problem. As explained before, this example demonstrate the control of CST eigenmode solver only.

## Error, help, suggestion, and so on
If you find any error while using it, please use the stackoverflow place to write about the error. It will be highly appreciated if you explain the problem in detail and also it will be convenient if you add the sample code which would be helpful to reproduce the error. Please note that, currently Mat2CST can be used for eigenmode solver, questions regarding to this solver will have high priority compared to questions on any other solvers.

## Disclaimer
A best effort has been made to check and verify the code before release. However, sometimes due to unforseen errors, the code might produce errors which might be due to the computer you are using or internal bugs in the COM interfaces. Also, note that, all the errors cannot be solved but only a workaround can be found.

## References
1. CSTMICROWAVE STUDIO 2017. http://www.cst.com: CST AG, Darmstadt, Germany.
2. MATLAB. (2017A). Natick, Massachusetts: The MathWorks Inc.
