function SimulationSymmetryPlane(varargin)
%% SimulationSymmetryPlane(mws,Xsymmetry,Ysymmetry,Zsymmetry)
% This function sets the symmetry planes conditions.
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             Xsymmetry: String ["none","electric","magnetic"]
%                            This specifes the boundary conditon for the
%                            X-plane i.e on yz plane and 
%                            can take any one of the string value
%                            specified in the bracket. None specifies no
%                            symmetry plane, electric specifies the PEC
%                            condition or Et=0, and magnetic specifies that
%                            the PMC codnition of Ht=0.
%             Ysymmetry: String ["none","electric","magnetic"]
%                            This specifes the boundary conditon for the
%                            Y-plane i.e on xy plane and 
%                            can take any one of the string value
%                            specified in the bracket. None specifies no
%                            symmetry plane, electric specifies the PEC
%                            condition or Et=0, and magnetic specifies that
%                            the PMC codnition of Ht=0.  
%             Zsymmetry: String ["none","electric","magnetic"]
%                            This specifes the boundary conditon for the
%                            z-plane i.e on xy plane and 
%                            can take any one of the string value
%                            specified in the bracket. None specifies no
%                            symmetry plane, electric specifies the PEC
%                            condition or Et=0, and magnetic specifies that
%                            the PMC codnition of Ht=0.
%
% Returns:  Default all the  settings are stored in the log file
%
% Raises:     argumentError: mismatch or inadequate or invalid arguments for the
%                            function


%% Checking the arguments
% minimum numbers of input arguments allowed
minInputs = 4;
% maximum numbers of input arguments allowed
maxInputs = 4;
% checking for minumum number of arguments
narginchk(minInputs,maxInputs)
% checking symmetry plane conditions
for i = 2 : 4
    
    assert(strcmp(varargin{i},'none') |strcmp(varargin{i},'electric') |strcmp(varargin{i},'magnetic'),...
        'Invalid input, please specify "none" or   "electric",  or "magnetic".')
end

%% assigning the symmetry palne conditions
YZ = varargin{2};
XZ = varargin{3};
XY = varargin{4};
boundary = invoke(varargin{1},'Boundary');
invoke(boundary,'Xsymmetry',YZ);
invoke(boundary,'Ysymmetry',XZ);
invoke(boundary,'Zsymmetry',XY);
boundary.release
%% Writing all the symmetry plane setting into a log file
disp('Boundary Condition  for symmetry plane are applied sucessfully');
end