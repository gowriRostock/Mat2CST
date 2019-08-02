function  [cst,mws1] = OpenCST(varargin)
%% OpenCST(fileLocation [,cstVersion])
% This function opens a cst window if already not open and then
% opens an existing cst file. 
% Parameters: fileLocation:  String type
%                            Specifies the location of the existing cst file
%                            to be opened
%                             
%                cstVersion:  Integer type, optional
%                             Version of cst. 2014 or 2016, or 2017. By
%                             default latest version installed will be
%                             used.
% Returns:    mws1: COM object model
%                    Returns the COM object model associated with the cst file
% Raises:     argumentError: mismatch or inadequate arguments for the
%                            function
%              cstVersionError: this cst version is not installed in your
%                               pc (not implemented yet)
%              fileLocationError: cst file is not found at the specified location
%            

%% Change log for improvement or bug removal
% 04.04.2019: Rectified the error happening when the opened cst file was
% tried to open again. 

%%
pathwithfilename = varargin{1};
global project_location;
global finalpath;
global mws2;
if exist(pathwithfilename, 'file')
    app = 'CSTStudio.application';
    dot = '.';
    [~,m] = size(varargin);
    if m==1 % if no CST version is specfied
        cst = actxserver(strcat(app));
        disp('CST opened successfully');
    elseif m==2 % if CST version is specfied open with that particular cst version
        version = int2str(varargin{2});
        cst = actxserver(strcat(app,dot,version));
        disp(['CST version ',int2str(varargin{2}),' opened successfully :-)']);
    end
    mws1 = invoke(cst, 'OpenFile',pathwithfilename);
    % If mws1 returns an empty string it means cst file is already open.
    % If CST file is open it returns an empty argument and also the
    % active window will be the file which was tried to open.
    if isempty(mws1)
        mws1=invoke(cst,'Active3D');
        disp(['CST file located at ',pathwithfilename,' is already open']);
    else
        disp(['CST file located at ',pathwithfilename,' was opened succesfully']);
    end

        mws2 = mws1;
% To make a log file in the current cst folder
        project_location =  invoke(mws2,'GetProjectPath','Project');
        [~,deepestFolder] = fileparts(project_location);
        newSubFolder = sprintf('%s/LogFile_%s', project_location, deepestFolder);
        if ~exist(newSubFolder, 'dir')
            mkdir(newSubFolder);
        end
        slash = '\';
        filename = datestr(now,'yyyy_mm_dd_HH_MM');
        name = '_log.txt';
        finalpath = strcat(newSubFolder,slash,filename,name);
else  
    % WARNING MESSAGEE IN gui if cst file is not found
    warningMessage = sprintf('Warning : Path/File does not exist: \n %s ', pathwithfilename);
    uiwait(msgbox(warningMessage));
end

