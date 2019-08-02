function Frequency = EigenFrequency(varargin)
%% EigenFrequency(mws,modes)
% This function sets the lower and upper frequency settings of CST.
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             modes: string("All")/Integer/range
%                   This specifies frequency of how many modes need to be
%                   read. "All", then frequencies of all the modes computed
%                   are read, Integer, for example 3, then only the
%                   frequency of the specific mode is read, and range for
%                   example "2-8", frequencies of all the mode between the
%                   range are read from CST. It is not possivle to use
%                   combination of integer and range in same function as we
%                   do in actual CST.
%
% Returns: All the eigen frequencies specified by "modes" argumant of the function
%           Default all the  eigenfrequencies are stored in the log file
%
% Raises:   argumentError: mismatch or inadequate or invalid arguments for the
%                            function

%% Checking the arguments
narginchk(1,3);
tic;

%% reading the eigenfrequencies of the modes
Eigenmodesolver = invoke(varargin{1},'EigenmodeSolver');
NumberOfModes = invoke(Eigenmodesolver,'GetNumberOfModesCalculated');
if strcmp(varargin{2},'All') %EigenFrequency(mws,'All') => returns all eigen mode frequencies
    Frequency = zeros(1,NumberOfModes);
    Mode_Number = zeros(1,NumberOfModes);
    for i = 1:NumberOfModes
        Frequency(i) = invoke (Eigenmodesolver,'GetModeFrequencyInHz',i);
        Mode_Number(i)= i;
    end
elseif (ischar(varargin{2})== 0)
    if (varargin{2} > 0) && (varargin{2} <= NumberOfModes) %EigenFrequency(mws,5)
        Frequency(1)= invoke (Eigenmodesolver,'GetModeFrequencyInHz',varargin{2});
        Mode_Number(1)= varargin{2};
    end
elseif (ischar(varargin{2})==1)
    rangeSize=strsplit(varargin{2},'-');
    min = str2num(cell2mat((rangeSize(1,1))));
    max = str2num(cell2mat((rangeSize(1,2))));
    assert(((0< max) &&(max <=NumberOfModes)),'Invalid Mode range. Please specify correct mode range e.g 02-09 ');
    assert(((0< min) &&(min <=NumberOfModes)),'Invalid Mode range.');
    Frequency = zeros(1,max-min+1);
    Mode_Number = zeros(1,max-min+1);
    for i = min:max
        Frequency(i-min+1)= invoke (Eigenmodesolver,'GetModeFrequencyInHz',i);
        Mode_Number(i-min+1)= i;
    end
end
computationTime = toc;

%% To write the eigenfrequencies into the log file
global finalpath;
global fileid;
fileid = fopen(finalpath, 'a');
fprintf(fileid,'\r\n____________________________________________________________________________________\r\n ');
fprintf(fileid,'\r\t Date & Time : ');
% fprintf(fileid, '%s\r\n', datetime('now','Format','dd-MMM-yyyy HH:mm:ss'));
fprintf(fileid,'\r\n\r\t%s\r\n','====================== Eigen Frequencies ====================== ');
fprintf(fileid,'\r\n\r\t\r\t%s\r\t%s\r\n','Mode Number','Frequency(in Hz)');
for i = 1 : length(Mode_Number)
    fprintf(fileid,'\r\n\r\t\r\t%s\r\t\r\t%s\r\t\r\n',int2str(Mode_Number(i)),Frequency(i));
end
fprintf(fileid, '\r\n\r\t Computation  Time (in seconds) = %s ', computationTime);
fprintf(fileid,'\r\n____________________________________________________________________________________\r\n ');
fclose(fileid);
Eigenmodesolver.release;
end
