function AnalysisW(SystemStates,LaplacianMatrix,Precision)

fid = fopen('PostProcessedW.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

for RowCounter = 1:NumberOfStates*NumberOfAgents
    for ColumnCounter = 1:NumberOfStates*NumberOfAgents
        fprintf(fid, 'VerifiedW%s%s = ', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'clean(replace(W(%s,%s), coefList, double(coefList)), %s);\n', num2str(RowCounter),num2str(ColumnCounter),num2str(Precision));
        fprintf(fid, 'W%s%s = ', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'sdisplay(VerifiedW%s%s);\n\n', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'clear VerifiedW%s%s;\n', num2str(RowCounter),num2str(ColumnCounter));
    end
end

fprintf(fid, 'W = [');

for RowCounter = 1:NumberOfStates*NumberOfAgents
    
    for ColumnCounter = 1:NumberOfStates*NumberOfAgents
        
             if ColumnCounter == NumberOfStates*NumberOfAgents && RowCounter == NumberOfStates*NumberOfAgents
                 
                 fprintf(fid, 'W%s%s];\n', num2str(RowCounter),num2str(ColumnCounter));
                 
             elseif ColumnCounter == NumberOfStates*NumberOfAgents
            
                 fprintf(fid, 'W%s%s;\n', num2str(RowCounter),num2str(ColumnCounter));
                 fprintf(fid, '     ');
                 
             else
                 
                 fprintf(fid, 'W%s%s, ', num2str(RowCounter),num2str(ColumnCounter));
                 
             end
            
        
    end
end

fclose(fid);

end