function SimulationFrequencySettings(varargin)
%% SimulationFrequencySettings(mws,fmin,fmax)
% This function sets the lower and upper frequency settings of CST.
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             fmin: Integer
%                   This specifies the frequency minimum for the
%                   simulations. Keep note of the units you have set in the
%                   CST and this should be without units. For example,in
%                   CST fequency has units MHz and you want to set fmin to
%                   200MHz then fmin should be 200.
%             fmin: Integer
%                   This specifies the frequency maximum for the
%                   simulations. Keep note of the units you have set in the
%                   CST.
%
% Returns:  Default all the  settings are stored in the log file
%
% Raises:   argumentError: mismatch or inadequate or invalid arguments for the
%                            function

%% Checking the arguments
minInputs = 3;   % minimum  numbers of input arguments allowed
% maximum numbers of input arguments allowed
maxInputs = 3;

% checking for minumum number of arguments
narginchk(minInputs,maxInputs);

fmin = varargin{2} ;
fmax = varargin{3} ;

assert(fmin<fmax,'Upper frequency must be larger than lower frequency.')
assert(fmin>=0 & fmax>=0,'Frequency can not be negative. ')

%% Assigning the frequency minimum and maximum in CST
solver = invoke(varargin{1},'Solver');
invoke(solver,'FrequencyRange',fmin,fmax);
disp(['Frequency setting applied with fmax at ',int2str(varargin{2}), ' and fmax at ',...
    int2str(varargin{3}), '.(For exact units refer the cst file)']);
solver.release
end
