function PostProcessingY(LinesVectorB,L,prec)

fid = fopen('PostProcessedY.m','w');

fprintf(fid, '%% Rewriting the matrix W\n');

NumberOfColumns = LinesVectorB;
NumberOfRows = size(L,1);

for nr = 1:NumberOfRows
    
    for nc = 1:NumberOfColumns
        
            
            fprintf(fid, 'VerifiedY%s%s = ', num2str(nr),num2str(nc));
            fprintf(fid, 'clean(replace(Y(%s,%s), coefList, double(coefList)), %s);\n', num2str(nr),num2str(nc),num2str(prec));
            fprintf(fid, 'Y%s%s = ', num2str(nr),num2str(nc));
            fprintf(fid, 'sdisplay(VerifiedY%s%s);\n\n', num2str(nr),num2str(nc));
            
        
    end
end

fprintf(fid, 'Y = [');

for nr = 1:NumberOfRows
    
    for nc = 1:NumberOfColumns
        
             if nc == NumberOfColumns && nr == NumberOfRows
                 
                 fprintf(fid, 'Y%s%s];\n', num2str(nr),num2str(nc));
                 
             elseif nc == NumberOfColumns
            
                 fprintf(fid, 'Y%s%s;\n', num2str(nr),num2str(nc));
                 fprintf(fid, '     ');
                 
             else
                 
                 fprintf(fid, 'Y%s%s, ', num2str(nr),num2str(nc));
                 
             end
            
    end
end
    
fclose(fid);
end