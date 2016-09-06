%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Title: Pre Processing Y                                                 %
% Description: Creates the matrix Y for the LMI optmization               %
% Inputs: nr. Integer, Scalar, Number of Rows                            %
%         nc. Integer, Scalar, Number of Columns   %
% Output: File 'CreatorWandDW.m' with the code definifn W and DW          %
% Author: Humberto Stein Shiromoto                                        %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% function test
% 
% SystemStates = ['w','x','y','z'];
% SystemInputs = ['u','v'];
% LaplacianMatrix = RandomLaplacianGenerator(3)
% Option = 'Neighbor';
% Ydegree = 2;
% WriterY1(SystemStates,SystemInputs,LaplacianMatrix,Option,Ydegree)
% 
% 
% end
% 
% function WriterY1(SystemStates,SystemInputs,LaplacianMatrix,Option,Ydegree)

function WriterY(SystemStates,SystemInputs,LaplacianMatrix,Option,Ydegree)

fid = fopen('PreProcessedY.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfInputs = length(SystemInputs);
NumberOfStates = length(SystemStates);

fprintf(fid, '%% NumberOfAgents = %d,\n%% NumberOfInputs = %d,\n%% NumberOfStates = %d,\n',NumberOfAgents,NumberOfInputs,NumberOfStates);

if strcmp(Option,'Diagonal')
    
    fprintf(fid, '\n%% Option = %s\n',Option);
    
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, '\n\n%% Starting Agent %d\n',AgentsCounter);
        for RowCounter = 1:NumberOfInputs
            fprintf(fid, '\n%% Writing Line %d\n',RowCounter);
            for ColumnCounter = 1:NumberOfStates
                
                fprintf(fid, '[');
                fprintf(fid, 'Yp%s%s%s,', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, 'Yc%s%s%s,', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, 'Yv%s%s%s]', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, ' = polynomial(');
                fprintf(fid, 'q%s,',num2str(AgentsCounter));
                fprintf(fid, '%f,0);\n',Ydegree);
                
            end
        end
        
        fprintf(fid, '\n%% Writing Matrix Y%d\n',AgentsCounter);
        fprintf(fid, 'Y%s = [',num2str(AgentsCounter));
        for RowCounter = 1:NumberOfInputs
            for ColumnCounter = 1:NumberOfStates
                
                fprintf(fid, 'Yp%s%s%s', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                
                if ColumnCounter == NumberOfStates
                
                    fprintf(fid, ';\n      ');
                    
                else
                    
                    fprintf(fid, ', ');
                    
                end
            end
        end
        fprintf(fid, '];\n');
        fprintf(fid, '\n%% Writing Vector Yc%d\n',AgentsCounter);
        fprintf(fid, 'Yc%s = [',num2str(AgentsCounter));
        for RowCounter = 1:NumberOfInputs
            for ColumnCounter = 1:NumberOfStates
                
                fprintf(fid, 'Yc%s%s%s', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                
                if ColumnCounter == NumberOfStates
                
                    fprintf(fid, ';\n       ');
                    
                else
                    
                    fprintf(fid, '; ');
                    
                end
            end
        end
        fprintf(fid, '];');
    end
    
    fprintf(fid, '\n\n%% Writing Matrix Y\n');
    fprintf(fid, 'Y = blkdiag(');
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, 'Y%s',num2str(AgentsCounter));
        if AgentsCounter < NumberOfAgents
            fprintf(fid, ',');
        end
    end
    fprintf(fid, ');');
    
    fprintf(fid, '\n\n%% Writing Vector Yc\n');
    fprintf(fid, 'Yc = [');
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, 'Yc%s;',num2str(AgentsCounter));
    end
    fprintf(fid, '];');
end

if strcmp(Option,'Diagonal') + strcmp(Option,'Neighbor') == 0
    
    fprintf(fid, '\n%% No Option Defined: Option = %s\n',Option);
    
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, '\n\n%% Starting Agent %d\n',AgentsCounter);
        for RowCounter = 1:NumberOfInputs
            fprintf(fid, '\n%% Writing Line %d\n',RowCounter);
            for ColumnCounter = 1:NumberOfStates*NumberOfAgents
                
                fprintf(fid, '[');
                fprintf(fid, 'Yp%s%s%s,', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, 'Yc%s%s%s,', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, 'Yv%s%s%s]', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, ' = polynomial(');
                fprintf(fid, 'q,');
                fprintf(fid, '%f,0);\n',Ydegree);
                
            end
        end
    end
    
    fprintf(fid, '\n%% Writing Vector Yc\n');
    fprintf(fid, 'Yc = [');
    
    for AgentsCounter = 1:NumberOfAgents
        for RowCounter = 1:NumberOfInputs
            for ColumnCounter = 1:NumberOfStates*NumberOfAgents
                
                if ColumnCounter == NumberOfStates*NumberOfAgents
                    
                    fprintf(fid, 'Yc%s%s%s;\n      ', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                else
                    
                    fprintf(fid, 'Yc%s%s%s; ', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                end
                
            end
        end
    end
    
    fprintf(fid, '];\n');
    
    fprintf(fid, '\n%% Writing Matrix Y\n');
    fprintf(fid, 'Y = [');
    
    for AgentsCounter = 1:NumberOfAgents
        for RowCounter = 1:NumberOfInputs
            for ColumnCounter = 1:NumberOfStates*NumberOfAgents
                
                if ColumnCounter == NumberOfStates*NumberOfAgents
                    
                    fprintf(fid, 'Yp%s%s%s;\n     ', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                else
                    
                    fprintf(fid, 'Yp%s%s%s, ', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                end
                
            end
        end
    end
    
    fprintf(fid, '];\n');
    
end

if strcmp(Option,'Neighbor')
    
    fprintf(fid, '\n%% Option = %s\n',Option);
    
    for RowAgentsCounter = 1:NumberOfAgents
        
        fprintf(fid, '\n\n%% Starting Agent %d\n',RowAgentsCounter);
        NonZeroIndexes = find(LaplacianMatrix(RowAgentsCounter,:));
        
        for ColumnAgentsCounter = 1:NumberOfAgents
            
            if LaplacianMatrix(RowAgentsCounter,ColumnAgentsCounter) ~= 0
                for RowCounter = 1:NumberOfInputs
                    fprintf(fid, '\n%% Writing Line %d\n',RowCounter);
                    for ColumnCounter = 1:NumberOfStates
                        
                        fprintf(fid, '[');
                        fprintf(fid, 'Yp%s%s%s,', num2str(RowAgentsCounter),num2str(RowCounter),num2str(ColumnCounter + (ColumnAgentsCounter - 1)*NumberOfStates));
                        fprintf(fid, 'Yc%s%s%s,', num2str(RowAgentsCounter),num2str(RowCounter),num2str(ColumnCounter + (ColumnAgentsCounter - 1)*NumberOfStates));
                        fprintf(fid, 'Yv%s%s%s]', num2str(RowAgentsCounter),num2str(RowCounter),num2str(ColumnCounter + (ColumnAgentsCounter - 1)*NumberOfStates));
                        fprintf(fid, ' = polynomial([');
                        for i=1:length(NonZeroIndexes)
                            fprintf(fid, 'q%s;',num2str(NonZeroIndexes(i)));
                        end
                        fprintf(fid, '],%f,0);\n',Ydegree);
                        
                    end
                end
                
            else
                
                for RowCounter = 1:NumberOfInputs
                    fprintf(fid, '\n%% Writing Line %d with Zeros\n',RowCounter);
                    for ColumnCounter = 1:NumberOfStates
                        fprintf(fid, 'Yp%s%s%s = 0;\n', num2str(RowAgentsCounter),num2str(RowCounter),num2str(ColumnCounter + (ColumnAgentsCounter - 1)*NumberOfStates));
                    end
                end
                
            end
            
        end
        
        fprintf(fid, '\n%% Writing the Components of Y(%d,:)\n',RowAgentsCounter);
        TempCounter = 1;
        for ColumnAgentsCounter = 1:NumberOfAgents
            
                for RowCounter = 1:NumberOfInputs
                    
                    if TempCounter <= NumberOfInputs
                        
                        fprintf(fid, 'Y%s%s = [',num2str(RowAgentsCounter),num2str(RowCounter));        
                        
                    else
                        
                        fprintf(fid, 'Y%s%s = [Y%s%s, ',num2str(RowAgentsCounter),num2str(RowCounter),num2str(RowAgentsCounter),num2str(RowCounter));     
                        
                    end
                    
                    for ColumnCounter = 1:NumberOfStates
                        
                        fprintf(fid, 'Yp%s%s%s', num2str(RowAgentsCounter),num2str(RowCounter),num2str(ColumnCounter + (ColumnAgentsCounter - 1)*NumberOfStates));
                        
                        if ColumnCounter < NumberOfStates
                            fprintf(fid, ', ');                            
                        end
                        
                    end
                    
                    fprintf(fid,'];\n');
                    
                    TempCounter = TempCounter + 1;
                end
                
            
            
        end
        
        fprintf(fid, 'Y%s = [',num2str(RowAgentsCounter));
        for InputsCounter = 1:NumberOfInputs
            fprintf(fid, 'Y%s%s; ',num2str(RowAgentsCounter),num2str(InputsCounter));
        end
        fprintf(fid, '];\n');
        
    end
    
    fprintf(fid, '\n%% Writing Vector Yc\n');
    fprintf(fid, 'Yc = [');
    for RowAgentsCounter = 1:NumberOfAgents
        for ColumnAgentsCounter = 1:NumberOfAgents
            
            if LaplacianMatrix(RowAgentsCounter,ColumnAgentsCounter) ~= 0
                for RowCounter = 1:NumberOfInputs
                    for ColumnCounter = 1:NumberOfStates
                        
                        fprintf(fid, 'Yc%s%s%s; ', num2str(RowAgentsCounter),num2str(RowCounter),num2str(ColumnCounter + (ColumnAgentsCounter - 1)*NumberOfStates));
                        
                    end
                end
            end
            
        end
    end
    fprintf(fid, '];\n');
    
    fprintf(fid, '\n%% Writing Matrix Y\n');
    fprintf(fid, 'Y = [');
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, 'Y%s;',num2str(AgentsCounter));
    end
    fprintf(fid, '];\n');
end

fclose(fid);

end