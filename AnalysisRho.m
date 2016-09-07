%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% File: AnalysisRho                                                       %
% Git Branch: Master                                                      %
% Author: H. Stein Shiromoto                                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function AnalysisRho(SystemStates,LaplacianMatrix,Precision)

fid = fopen('PostProcessedRho.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

for RowCounter = 1:NumberOfStates*NumberOfAgents
    for ColumnCounter = 1:NumberOfStates*NumberOfAgents
        fprintf(fid, 'VerifiedR%s%s = ', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'clean(replace(R(%s,%s), coefList, double(coefList)), %s);\n', num2str(RowCounter),num2str(ColumnCounter),num2str(Precision));
        fprintf(fid, 'R%s%s = ', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'sdisplay(VerifiedR%s%s);\n\n', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'clear VerifiedR%s%s;\n', num2str(RowCounter),num2str(ColumnCounter));
    end
end

fprintf(fid, 'R = [');

for RowCounter = 1:NumberOfStates*NumberOfAgents
    
    for ColumnCounter = 1:NumberOfStates*NumberOfAgents
        
             if ColumnCounter == NumberOfStates*NumberOfAgents && RowCounter == NumberOfStates*NumberOfAgents
                 
                 fprintf(fid, 'R%s%s];\n', num2str(RowCounter),num2str(ColumnCounter));
                 
             elseif ColumnCounter == NumberOfStates*NumberOfAgents
            
                 fprintf(fid, 'R%s%s;\n', num2str(RowCounter),num2str(ColumnCounter));
                 fprintf(fid, '     ');
                 
             else
                 
                 fprintf(fid, 'R%s%s, ', num2str(RowCounter),num2str(ColumnCounter));
                 
             end
            
        
    end
end

fclose(fid);

end