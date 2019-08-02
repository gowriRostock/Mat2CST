function SimulationBoundaries(varargin)
%% SimulationBoundaries(mws,ApplyInAllDirections,Xmin[,Xmax,Ymin,Ymax,Zmin,Zmax])
% This function sets the boundary condition.
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             ApplyInAllDirections: Logical string ["True","False"]
%                            This specifes wether there is a common
%                            boundary condition for all the directions. Can
%                            take two values true or false. If true, then
%                            only the xmin argument should be specified
%                            otherwise all the six succeding arguments
%                            needs to be specified.
%             Xmin: String ["electric","magnetic"]
%                            This specifes the boundary conditon for the
%                            Xmin. Currently it can support electric and
%                            magnetic boundary conditions only.
%             Xmax,Ymin,Ymax,Zmin,Zmax: String ["electric","magnetic"],optional
%                            This specifes the boundary conditon for the
%                            Xmax,Ymin,Ymax,Zmin and Zmax. Currently it can
%                            support only electric and magnetic boundary
%                            ocnditions only.
%
% Returns:  Default all the  settings are stored in the log file
%
% Raises:     argumentError: mismatch or inadequate or invalid arguments for the
%                            function

%% Checking the arguments


assert(strcmp(varargin{2},'True') |strcmp(varargin{2},'False'),...
    'Invalid input, please specify "True" or   "False" .')

boundary = invoke(varargin{1},'Boundary');

if strcmp(boundary.invoke('GetXsymmetry'),'none')~= 1 ||strcmp(boundary.invoke('GetYsymmetry'),'none')~= 1 ||strcmp(boundary.invoke('GetZsymmetry'),'none')~= 1
    
    warning('You had set some symmerty plane condition. Be sure that you had set them accurately and set all boundary conditions properly.');
end

%% Assignning the boudnary conditions

if  strcmp(varargin{2}, 'True')==1 % example SimulationBoundaries(mws,'True','electric')
    
    % minimum numbers of input arguments allowed
    minInputs = 3;
    % maximum numbers of input arguments allowed
    maxInputs = 3;
    
    % checking for minumum number of arguments
    narginchk(minInputs,maxInputs)
    
    assert(strcmp(varargin{3},'none') |strcmp(varargin{3},'electric') |strcmp(varargin{3},'magnetic'),...
        'Invalid input, please specify "none" or   "electric",  or "magnetic".')
    
    invoke(boundary,'ApplyInAllDirections','True');
    invoke(boundary,'Xmin',varargin{3});
    invoke(boundary,'Xmax',varargin{3});
    invoke(boundary,'Ymin',varargin{3});
    invoke(boundary,'Ymax',varargin{3});
    invoke(boundary,'Zmin',varargin{3});
    invoke(boundary,'Zmax',varargin{3});
    disp('Boundary Condition  are applied sucessfully');
    boundary.release
    
else
    % minimum numbers of input arguments allowed
    minInputs = 8;
    % maximum numbers of input arguments allowed
    maxInputs = 8;
    
    % checking for minumum number of arguments
    narginchk(minInputs,maxInputs)
    
    for i = 3 : 8
        assert(strcmp(varargin{i},'none')|strcmp(varargin{i},'electric')|strcmp(varargin{i},'magnetic'),...
            'Invalid input, please specify  "electric",  or "magnetic".')
    end
    
    invoke(boundary,'ApplyInAllDirections','False');
    invoke(boundary,'Xmin',varargin{3});
    invoke(boundary,'Xmax',varargin{4});
    invoke(boundary,'Ymin',varargin{5});
    invoke(boundary,'Ymax',varargin{6});
    invoke(boundary,'Zmin',varargin{7});
    invoke(boundary,'Zmax',varargin{8});
    boundary.release
    disp('Boundary Condition  are applied sucessfully');
    
end

end