%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Git Branch: Master                                                      %
% Title: Pre Processing Rho                                               %
% Description: Creates the matrix R for the LMI optmization               %
% Inputs: nr. Integer, Scalar, Number of Rows                             %
%         nc. Integer, Scalar, Number of Columns                          %
% Output: File 'CreatorWandDW.m' with the code definifn W and DW          %
% Author: Humberto Stein Shiromoto                                        %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% function test
% 
% SystemStates = ['x','y','z'];
% SystemInputs = ['u'];
% LaplacianMatrix = LinearLaplacianGenerator(3)
% Rhodegree = 2;
% WriterRho1(SystemStates,SystemInputs,LaplacianMatrix,Option,Rhodegree)
% 
% 
% end
% 
% function WriterRho1(SystemStates,SystemInputs,LaplacianMatrix,Rhodegree)

function WriterRho(SystemStates,LaplacianMatrix,Rhodegree)

fid = fopen('PreProcessedRho.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

fprintf(fid, '%% NumberOfAgents = %d,\n%% NumberOfStates = %d,\n',NumberOfAgents,NumberOfStates);
    
    for RowAgentsCounter = 1:NumberOfAgents
        
        flag = 1;
        fprintf(fid, '\n\n%% Starting Agent %d\n',RowAgentsCounter);
        NonZeroIndexes = find(LaplacianMatrix(RowAgentsCounter,:));
        
        for ColumnAgentsCounter = 1:NumberOfAgents
            
            if LaplacianMatrix(RowAgentsCounter,ColumnAgentsCounter) ~= 0 && flag == 1
                
                fprintf(fid, '[');
                fprintf(fid, 'Rhop%s,', num2str(RowAgentsCounter));
                fprintf(fid, 'Rhoc%s,', num2str(RowAgentsCounter));
                fprintf(fid, 'Rhov%s]', num2str(RowAgentsCounter));
                fprintf(fid, ' = polynomial([');
                
                for i=1:length(NonZeroIndexes)
                    fprintf(fid, 'x%s;',num2str(NonZeroIndexes(i)));
                end
                fprintf(fid, '],%d,0);\n',Rhodegree);
                
                flag = 0;
            end
            
        end
        
    end
    
    fprintf(fid, '\n%% Writing the Matrix R\n');
    fprintf(fid, 'R = blkdiag(');
    for AgentsCounter = 1:NumberOfAgents
        
        fprintf(fid, 'Rhop%s*eye(%d)',num2str(AgentsCounter),NumberOfStates);
        
        if AgentsCounter == NumberOfAgents
            
            fprintf(fid, ');\n');
            
        else
            
            fprintf(fid, ', ');
            
        end
        
    end
    
    fprintf(fid, '\n%% Writing Vector Rhoc\n');
    fprintf(fid, 'Rhoc = [');
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, 'Rhoc%s', num2str(AgentsCounter));
        if AgentsCounter == NumberOfAgents
            fprintf(fid, '];\n');
        else
            fprintf(fid, '; ');
        end
    end

fclose(fid);

end