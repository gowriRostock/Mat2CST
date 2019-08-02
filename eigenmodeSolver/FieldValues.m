function [Ex,Ey,Ez,Hx,Hy,Hz,position] = FieldValues(varargin)
%% FieldValues(mws,Direction,startPoint,endPoint,throughPointCoordX,throughPointCoordY,modes)
% This function returns the electric and magnetic field values all along a
% LINE in a cartesian co-ordinate system for any mode. This works same as the
% macro available in result template (2D and 3D results/ Evaluate along the arbitary co-ordinates)
%
% Parameters: mws: COM object
%                    COM object model associated with the cst file
%             Direction: Character ["X","Y","Z"]
%                        Direction along which fields need to be
%                        evaluated in 1D co-ordinate
%             startPoint,endPoint: Integer
%                        These values define the starting and ending point
%                        of the curve i.e line.
%             throughPointCoordX,throughPointCoordY: Integer
%                         This specifies the point through
%                         which field values are extracted. For example
%             Direction           "X"         "Y"         "Z"
%             throughPointCoordX   Y           Z           X
%             throughPointCoordY   Z           X           Y
%
%             noOfSamples: Integer
%                          This specifies the number of field samples that
%                          will be calculated
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
% Returns: All the electric and magnetic field values along the X,Y,Z
% direction respectively and also the location along the Direction in
% position vector.
%  
% Raises:   argumentError: mismatch or inadequate or invalid arguments for the
%                            function

invoke(varargin{1},'Plot3DPlotsOn2DPlane','False');
plot = invoke(varargin{1},'Plot');
invoke (plot,'ShowCutPlane','False');
field_Data = invoke(varargin{1},'VectorPlot3D');
invoke(field_Data,'Reset');
Lstart = varargin{3};        % starting point of the curve i.e a
Lend = varargin{4} ;       	% ending point of the curve i.e b
NumberOfSamples = varargin{7};% n

format long;

% assert(isinteger(varargin{7}),'Invalid input, please specify integer data types ')
% assert(strcmp(varargin{8},'All')| isinteger(varargin{8}),'Invalid input, please specify "All" or exact mode number ')


Eigenmodesolver = invoke(varargin{1},'EigenmodeSolver');
NumberOfModes = invoke(Eigenmodesolver,'GetNumberOfModesCalculated');
position=zeros(1,NumberOfSamples+1);
if strcmp(varargin{2},'Z')
    for i= 0: NumberOfSamples
        position(i+1)=Lstart + i*(Lend-Lstart)/NumberOfSamples;
        z = Lstart + i*(Lend-Lstart)/NumberOfSamples;
        x = varargin{5};
        y =  varargin{6};
        invoke(field_Data,'AddListItem',x,y,z);
    end
    
end

if strcmp(varargin{2},'Y')
    for i= 0: NumberOfSamples
        position(i+1)=Lstart + i*(Lend-Lstart)/NumberOfSamples;
        y = Lstart + i*(Lend-Lstart)/NumberOfSamples;
        z = varargin{5};
        x =  varargin{6};
        invoke(field_Data,'AddListItem',x,y,z);
    end
    
end

if strcmp(varargin{2},'X')
    for i= 0: NumberOfSamples
        position(i+1)=Lstart + i*(Lend-Lstart)/NumberOfSamples;
        x = Lstart + i*(Lend-Lstart)/NumberOfSamples;
        y = varargin{5};
        z =  varargin{6};
        invoke(field_Data,'AddListItem',x,y,z);
    end
end

if strcmp(varargin{8},'All') 
    for i= 1 :NumberOfModes
        result = ['2D/3D Results\Modes\Mode ',int2str(i),'\e'];
        invoke(varargin{1},'SelectTreeItem',result);
        invoke(field_Data,'calculatelist');
        Ex(:,i) = invoke(field_Data,'getlist','xre');
        Ey(:,i) = invoke(field_Data,'getlist','yre');
        Ez(:,i) = invoke(field_Data,'getlist','zre');
        
        % for h fied
        result2 = ['2D/3D Results\Modes\Mode ',int2str(i),'\h'];
        invoke(varargin{1},'SelectTreeItem',result2);
        invoke(field_Data,'calculatelist');
        Hx(:,i) = invoke(field_Data,'getlist','xim');
        Hy(:,i) = invoke(field_Data,'getlist','yim');
        Hz(:,i) = invoke(field_Data,'getlist','zim');
    end
elseif (ischar(varargin{8})== 0)%FieldValues(mws,....5)
    if (varargin{8} > 0) && (varargin{8} <= NumberOfModes)
        % for e fied
        result = ['2D/3D Results\Modes\Mode ',int2str(varargin{8}),'\e'];
        invoke(varargin{1},'SelectTreeItem',result);
        invoke(field_Data,'calculatelist');
        Ex = invoke(field_Data,'getlist','xre');
        Ey = invoke(field_Data,'getlist','yre');
        Ez = invoke(field_Data,'getlist','zre');
        
        % for h fied
        result2 = ['2D/3D Results\Modes\Mode ',int2str(varargin{8}),'\h'];
        invoke(varargin{1},'SelectTreeItem',result2);
        invoke(field_Data,'calculatelist');
        Hx = invoke(field_Data,'getlist','xim');
        Hy = invoke(field_Data,'getlist','yim');
        Hz = invoke(field_Data,'getlist','zim');
    end
elseif (ischar(varargin{8})== 1)
    rangeSize=strsplit(varargin{8},'-');
    min = str2num(cell2mat((rangeSize(1,1))));
    max = str2num(cell2mat((rangeSize(1,2))));
    assert(((0< max) &&(max <=NumberOfModes)),'Invalid Mode range. Please specify correct mode range e.g 02-09 ');
    assert(((0< min) &&(min <=NumberOfModes)),'Invalid Mode range.');
    for i = min:max
        % for e fied
        result = ['2D/3D Results\Modes\Mode',' ',int2str(i),'\e'];
        invoke(varargin{1},'SelectTreeItem',result);
        invoke(field_Data,'calculatelist');
        Ex(:,i-min+1) = invoke(field_Data,'getlist','xre');
        Ey(:,i-min+1) = invoke(field_Data,'getlist','yre');
        Ez(:,i-min+1) = invoke(field_Data,'getlist','zre');
        % for h fied
        result2 = ['2D/3D Results\Modes\Mode',' ',int2str(i),'\h'];
        invoke(varargin{1},'SelectTreeItem',result2);
        invoke(field_Data,'calculatelist');
        Hx(:,i-min+1) = invoke(field_Data,'getlist','xim');
        Hy(:,i-min+1) = invoke(field_Data,'getlist','yim');
        Hz(:,i-min+1) = invoke(field_Data,'getlist','zim');
    end
end
Eigenmodesolver.release;
plot.release;
field_Data.release;
end