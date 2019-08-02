function EigenmodeSolverSetting(varargin)
%% EigenmodeSolverSetting(mws,meshType=("Tet"), noOfModes, frequencyAbove)
%% EigenmodeSolverSetting(mws,meshType=("Hex"), Method=(AKS), noOfModes)
%% EigenmodeSolverSetting(mws,meshType=("Hex"), Method=(JDM), noOfModesAutomatically[,noOfModes,frequencyAbove])
% This function sets the eigenmode solver settings. This function can be
% called in three ways as mentioned above.
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             meshType: string ["Tet","Hex"]
%                            This specifes wether the solver should use
%                            tetrahedral (tet) or hexahedral (hex) mesh.
%             noOfModes: Integer 
%                            This specifes the number of modes to be
%                            computed by the solver.
%             frequencyAbove: Integer
%                            This specifes the frequency above which the
%                            eigenmodes need to be calculated.
%             Method: String ["AKS","JDM"]
%                            This specifes the method to be used while
%                            using hexahedral meshes,namely AKS 
%                            (Advanced Krylov Subspace) and 
%                            JDM (Jacobi-Davidson Method). 
%             noOfModesAutomatically: Logical string ["True","False"]
%                            This specifes the whether the solver
%                            calculates the number of eigenmodes based
%                            autmoatically ("True") or not ("False"). If
%                            false then noOfModes and frequencyAbove need
%                            to be specified.
%
% Raises:     argumentError: mismatch or inadequate or invalid arguments for the
%                            function

%% Checking the arguemtns


assert(strcmp(varargin{2},'Hexa') |strcmp(varargin{2},'Tetra'),...
    'Invalid input, please specify "Hexa" or "Tetra" for Mesh type \n')


%% Assign the paramters
Eigenmodesolver = invoke(varargin{1},'EigenmodeSolver');


% user can comment the below command if they want to keep the already
% specified conditions in the eigenmode solver settings window
% invoke(Eigenmodesolver,'reset'); 

% For hexahedral mesh
if strcmp(varargin{2},'Hexa')
    assert(strcmp(varargin{3},'AKS') |strcmp(varargin{3},'JDM'),...
        'Invalid input, please specify "AKS" or "JDM" for method ')
    if strcmp(varargin{3},'AKS')
        minInputs = 4;
        maxInputs = 4;
        narginchk(minInputs,maxInputs);
        assert(isinteger(varargin{4})| isfloat(varargin{4}),...
            'Invalid input,number of modes should be integer of float type  ');      
        invoke(Eigenmodesolver,'SetMeshType','Hexahedral Mesh');
        invoke(Eigenmodesolver,'SetMethod',varargin{3});
        invoke(Eigenmodesolver,'SetNumberOfModes',int2str(varargin{4}));
        disp('The Eigenmode solver parameter settings is applied sucessflly ')
    else  % method is JDM case
        assert(strcmp(varargin{4},'True') |strcmp(varargin{4},'False'),...
            'Invalid input, please specify "True" for choosing number of modes automatically otherwise "False"  \n')
        if strcmp(varargin{4},'True')% true: choosing number of modes automatically for JDM case
            minInputs = 4;
            maxInputs = 4;
            narginchk(minInputs,maxInputs);           
            invoke(Eigenmodesolver,'SetMeshType','Hexahedral Mesh');
            invoke(Eigenmodesolver,'SetMethod',varargin{3});
            invoke(Eigenmodesolver,'SetFrequencyTarget','False',0.0)
            disp('The Eigenmode solver parameter settings was applied sucessflly')
        else % False: choosing number of modes automatically for JDM case
            minInputs = 6;
            maxInputs = 6;
            narginchk(minInputs,maxInputs);
            f = varargin{6};
            assert(isinteger(varargin{5})| isfloat(varargin{5}),'Invalid input,number of modes should be integer or float type \n ');
            solver = invoke(varargin{1},'Solver');
            fmax = invoke(solver,'GetFmax');
            fmin = invoke(solver,'GetFmin');
            assert( (fmin <= f | f<= fmax),...
                'Invalid input,frequencies above must be greater than or  equal to fmin and less than fmax');
            assert(isinteger(f)| isfloat(f),...
                'Invalid input,frequencies above should be integer or float type \n ');           
            invoke(Eigenmodesolver,'SetMeshType','Hexahedral Mesh');
            invoke(Eigenmodesolver,'SetMethod',varargin{3});
            %invoke(EigenmodeSolver,'SetModesInFrequencyRange','False');
            invoke(Eigenmodesolver,'SetNumberOfModes',int2str(varargin{5}));
            invoke(Eigenmodesolver,'SetFrequencyTarget','True',f);
            disp('The Eigenmode solver parameter settings was applied sucessflly')
        end
        
    end
else % Tetra hedral mesh type case
    minInputs = 4;
    maxInputs = 4;
    narginchk(minInputs,maxInputs);
    assert(isinteger(varargin{3})| isfloat(varargin{3}),...
        'Invalid input,number of modes should be integer of float type \n ');
    assert(isinteger(varargin{4})| isfloat(varargin{4}),...
        'Invalid input,frequencies above should be integer or float type \n ');
    solver = invoke(varargin{1},'Solver');
    fmax = invoke(solver,'GetFmax');
    fmin = invoke(solver,'GetFmin');
    f= varargin{4};
    assert(( fmin <= f | f<= fmax),...
        'Invalid input,frequencies above must be greater than or  equal to fmin and less than fmax  ');
    
    invoke(Eigenmodesolver,'SetMeshType','Tetrahedral Mesh');
    invoke(Eigenmodesolver,'SetNumberOfModes',int2str(varargin{3}));
    invoke(Eigenmodesolver,'SetFrequencyTarget','True',varargin{4});
    disp('The Eigenmode solver parameter settings was applied sucessflly')
end
Eigenmodesolver.release
end




