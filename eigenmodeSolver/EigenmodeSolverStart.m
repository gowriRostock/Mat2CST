function EigenmodeSolverStart(varargin)
%% EigenmodeSolverStart(mws)
% This function starts the eigenmode solver and stores the exectution time
% in the log file
% Parameters: mws: COM object
%                  COM object model associated with the cst file
%
%% Checking the arguments
narginchk(1,1);
%% Assign the paramters
% invoke(varargin{1},'Rebuild');
Eigenmodesolver = invoke(varargin{1},'EigenmodeSolver');
% invoke(Eigenmodesolver,'Apply');
tic;
disp('Eigenmode solver started ...');
status=Eigenmodesolver.invoke('Start');
Eigenmodesolver.release;
computationTime = toc;
if status==1
    disp(['Eigenmode solver running was successfull and was completede in ',num2str(computationTime),' Seconds']);
else
    disp('Eigenmode solver running was not successfull. Please refer the cst file.');
end
%% To write the data into log file
global fileid;
global finalpath;
fileid = fopen(finalpath, 'a');
fprintf(fileid,'\r\n____________________________________________________________________________________\r\n ');
fprintf(fileid,'\r\t Date & Time : ');
% fprintf(fileid, '%s\r\n', datetime('now','Format','dd-MMM-yyyy HH:mm:ss'));
fprintf(fileid, '\r\n\r\t Eigen Mode Computation  Time (in seconds) = %s ', computationTime);
fprintf(fileid,'\r\n____________________________________________________________________________________\r\n ');
fclose(fileid);
end