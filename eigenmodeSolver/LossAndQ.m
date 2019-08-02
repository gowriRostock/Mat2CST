function [L,Q] = LossAndQ(varargin)
%% LossAndQ(mws,modes,material,conductivity])
% This function computes the total loss and Q of the cavity
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             modes: string("All")/Integer/range
%                   This specifies loss and Q of how many modes need to be
%                   read. "All", then loss and Q of all the modes computed
%                   are read. Integer, for example 3, then only the
%                   loss and Q of the specific mode is read. And, range, for
%                   example "2-8", loss and Q of all the mode between the
%                   range are read from CST. It is not possible to use
%                   combination of integer and range in same function as we
%                   do in actual CST.
%             material: String
%                   This specifies the material name
%             conductivity: integer
%                   This specifies the conducitivty of the material
%
% Returns:  Loss and Qualtiy factor of the modes specfied in themodes argument.
%            Further by default all the  values are stored in the log file.
%
% Raises:   argumentError: mismatch or inadequate or invalid arguments for 
%                         the   function
%           Invalid Mode range: If mode range is out of range, that is mode
%            requested is out of calculated modes

%% Initializing the paramters
tic;
Eigenmodesolver = invoke(varargin{1},'EigenmodeSolver');
NumberOfModes = invoke(Eigenmodesolver,'GetNumberOfModesCalculated');
material_or_solid = varargin{3};
conductivity = varargin{4};
str_g = sprintf('%0.5g',conductivity);


%% Loss and Q for all the modes
if strcmp(varargin{2},'All')
    Q = ones(1,NumberOfModes);
    L = ones(1,NumberOfModes);
    Mode_Number=ones(1,NumberOfModes);
    %Qfactor and loss calculation
    Qfactor = invoke(varargin{1},'QFactor');
    for i = 1:NumberOfModes
        invoke(Qfactor,'reset');
        invoke(Qfactor,'SetHField',['Mode ',int2str(i)]);
        invoke(Qfactor,'SetConductivity',material_or_solid, str_g);
        invoke(Qfactor,'Calculate');
        Mode_Number(:,i)= i;
        Q(:,i)= invoke (Qfactor,'GetTotalQ');
        L(:,i)= invoke(Qfactor,'GetTotalLossRMS');
    end
elseif (ischar(varargin{2})== 0)
    if (varargin{2} > 0) && (varargin{2} <= NumberOfModes)
        %Qfactor and loss calculation
        Qfactor = invoke(varargin{1},'QFactor');
        invoke(Qfactor,'reset');
        invoke(Qfactor,'SetHField',['Mode ',int2str(varargin{2})]);
        invoke(Qfactor,'SetConductivity',material_or_solid, str_g);
        invoke(Qfactor,'Calculate');
        Mode_Number (1,1)= varargin{2};
        Q=invoke (Qfactor,'GetTotalQ');
        L=invoke(Qfactor,'GetTotalLossRMS');
    end
elseif (ischar(varargin{2})== 1)
    rangeSize=strsplit(varargin{2},'-');
    min = str2num(cell2mat((rangeSize(1,1))));
    max = str2num(cell2mat((rangeSize(1,2))));
    assert(((0< max) &&(max <=NumberOfModes)),'Invalid Mode range. Please specify corrwect mode range e.g 02-09 ');
    assert(((0< min) &&(min <=NumberOfModes)),'Invalid Mode range.');
    Q = ones(1,max-min+1);
    L = ones(1,max-min+1);
    Mode_Number=ones(1,max-min+1);
    %Qfactor and loss calculation
    Qfactor = invoke(varargin{1},'QFactor');
    for i = min:max
        invoke(Qfactor,'reset');
        invoke(Qfactor,'SetHField',['Mode ',int2str(i)]);
        invoke(Qfactor,'SetConductivity',material_or_solid, str_g);
        invoke(Qfactor,'Calculate');
        Q(i-min+1)= invoke (Qfactor,'GetTotalQ');
        L(i-min+1) = invoke(Qfactor,'GetTotalLossRMS');
        Mode_Number(i-min+1) = i;
    end
end
computationTime = toc;

%% To write all the values into a log file
global fileid;
global finalpath;
fileid = fopen(finalpath, 'a');
fprintf(fileid,'\r\n____________________________________________________________________________________\r\n ');
fprintf(fileid,'\r\t Date & Time : ');
% fprintf(fileid, '%s\r\n', datetime('now','Format','dd-MMM-yyyy HH:mm:ss'));
fprintf(fileid,'\r\n\r\t%s\r\n','====================== Eigen Mode Solver Results: ====================== ');
fprintf(fileid,'\r\n\r\t\r\t%s\r\t%s\r\t\r\t%s\r\n','Mode Number','Q-Factor','Power Loss');
for i = 1 : length(Mode_Number)
    fprintf(fileid,'\r\n\r\t\r\t%s\r\t\r\t%s\r\t\r\t%s\r\t\r\n',int2str(Mode_Number(i)),Q(i),L(i));
end
fprintf(fileid, '\r\n\r\t Computation  Time (in seconds) = %s ', computationTime);
fprintf(fileid,'\r\n____________________________________________________________________________________\r\n ');
fclose(fileid);
Eigenmodesolver.release;
end