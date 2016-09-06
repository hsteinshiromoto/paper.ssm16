function PostProcessingW(NumberOfAgents,SystemDimension,prec,Option)

fid = fopen('PostProcessedW.m','w');

SysDim = SystemDimension;

fprintf(fid, '%% Rewriting the matrix W\n');

for nr = 1:NumberOfAgents*SysDim
    
    for nc = 1:NumberOfAgents*SysDim
        
        fprintf(fid, 'VerifiedW%s%s = ', num2str(nr),num2str(nc));
        fprintf(fid, 'clean(replace(W(%s,%s), coefList, double(coefList)), %s);\n', num2str(nr),num2str(nc),num2str(prec));
        fprintf(fid, 'W%s%s = ', num2str(nr),num2str(nc));
        fprintf(fid, 'sdisplay(VerifiedW%s%s);\n\n', num2str(nr),num2str(nc));
        
        
    end
end


fprintf(fid, 'W = [');

for nr = 1:NumberOfAgents*SysDim
    
    for nc = 1:NumberOfAgents*SysDim
        
             if nc == NumberOfAgents*SysDim && nr == NumberOfAgents*SysDim
                 
                 fprintf(fid, 'W%s%s];\n', num2str(nr),num2str(nc));
                 
             elseif nc == NumberOfAgents*SysDim
            
                 fprintf(fid, 'W%s%s;\n', num2str(nr),num2str(nc));
                 fprintf(fid, '     ');
                 
             else
                 
                 fprintf(fid, 'W%s%s, ', num2str(nr),num2str(nc));
                 
             end
            
        
    end
end

fclose(fid);
    

end