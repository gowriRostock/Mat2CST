function CloseFile(varargin)
 %% CloseFile(mws,save)
% This function saves the cst file based on the 'save' condition and then
% closes the cst file.
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             Save: Logical character ["True","False"]
%                   If true, then the file is saved before closing, else
%                   closed without saving. Note that in the 'False' codnition, only the
%                   results are discarded not the parametric change.
% Returns: None
%  
% Raises:   argumentError: mismatch or inadequate or invalid arguments for the
%                            function.
%% Checking arguments
narginchk(2,2);

%% Actual saving and closing
if varargin{2}=="True"
    invoke(varargin{1},'Save');
    invoke(varargin{1},'Quit');
else
    invoke(varargin{1},'ResetAll')
    invoke(varargin{1},'Rebuild')
    invoke(varargin{1},'Save');
    invoke(varargin{1},'Quit');
end