function CloseCST(varargin)
 %% CloseCST(cst)
% This function closes the cst window
% Parameters: cst: COM object
%                    COM object model associated with the cst studio window

% Returns: None
%  
% Raises:  argumentError: mismatch or inadequate or invalid arguments for the
%                            function.

%% Checking arguments
narginchk(1,1);
%% Closing the cst stduio window
invoke(varargin{1},'Quit');
end