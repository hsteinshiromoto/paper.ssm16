function AnalysisY(SystemInputs,LaplacianMatrix,Precision)

fid = fopen('PostProcessedY.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfInputs = length(SystemInputs);

for RowCounter = 1:NumberOfAgents
    for ColumnCounter = 1:NumberOfAgents*NumberOfInputs*2
        fprintf(fid, 'VerifiedY%s%s = ', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'clean(replace(Y(%s,%s), coefList, double(coefList)), %s);\n', num2str(RowCounter),num2str(ColumnCounter),num2str(Precision));
        fprintf(fid, 'Y%s%s = ', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'sdisplay(VerifiedY%s%s);\n\n', num2str(RowCounter),num2str(ColumnCounter));
        fprintf(fid, 'clear VerifiedY%s%s;\n', num2str(RowCounter),num2str(ColumnCounter));
    end
end

fprintf(fid, 'Y = [');

for RowCounter = 1:NumberOfAgents
    
    for ColumnCounter = 1:NumberOfAgents*NumberOfInputs*2
        
             if ColumnCounter == NumberOfAgents*NumberOfInputs*2 && RowCounter == NumberOfAgents
                 
                 fprintf(fid, 'Y%s%s];\n', num2str(RowCounter),num2str(ColumnCounter));
                 
             elseif ColumnCounter == NumberOfInputs*NumberOfAgents*2
            
                 fprintf(fid, 'Y%s%s;\n', num2str(RowCounter),num2str(ColumnCounter));
                 fprintf(fid, '     ');
                 
             else
                 
                 fprintf(fid, 'Y%s%s, ', num2str(RowCounter),num2str(ColumnCounter));
                 
             end
            
        
    end
end

fclose(fid);

end