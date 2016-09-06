%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Title: Writer W                                                         %
% Description: Creates the matrices W and DW for the LMI optmization      %
% Inputs: N. Integer, Scalar, Number of Agents                            %
%         SystemDimension. Integer, Scalar, Dimension of Each Subsystem   %
% Output: File 'CreatorWandDW.m' with the code definifn W and DW          %
% Author: Humberto Stein Shiromoto                                        %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% function test
% 
% SystemStates = ['x','y'];
% Wdegree = 2;
% ScalingFactor = 1e-2;
% LaplacianMatrix = LinearLaplacianGenerator(9)
% WriterW1(SystemStates,LaplacianMatrix,Wdegree,ScalingFactor)
% 
% end
% 
% function WriterW1(SystemStates,LaplacianMatrix,Wdegree,ScalingFactor)

function WriterW(SystemStates,LaplacianMatrix,Wdegree,ScalingFactor)

fid = fopen('PreProcessedW.m','w');

% Writing the matrix W

SystemDimension = length(SystemStates);
NumberOfAgents  = size(LaplacianMatrix,1);

for AgentsCounter = 1:NumberOfAgents
    
    % Writes the line of code
    % [Wpn11,Wcn11,Wvn11] = polynomial(qn,Wdegree,0);
    % Note W is written as a polynomial in the variable q
    fprintf(fid, '%% Creation of W%s and DW%s\n',num2str(AgentsCounter),num2str(AgentsCounter));
    
    for RowCounter = 1:SystemDimension
        
        for ColumnCounter = 1:SystemDimension
            
            if ColumnCounter >= RowCounter
                
                fprintf(fid, '[');
                fprintf(fid, 'Wp%s%s%s,', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, 'Wc%s%s%s,', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, 'Wv%s%s%s]', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                fprintf(fid, ' = polynomial(');
                fprintf(fid, 'q%s,', num2str(AgentsCounter));
                fprintf(fid, '%d,0);\n',Wdegree);
            
            end
            
        end
    end
    
    % Writes the matrix W whose elements are the polynomials Wp
    fprintf(fid, '%% Creation of W%s\n',num2str(AgentsCounter));
    
    fprintf(fid, 'W%s = [', num2str(AgentsCounter));
    
    for RowCounter = 1:SystemDimension
        
        if RowCounter > 1
            
            fprintf(fid, '      ');
            
        end
        
        for ColumnCounter = 1:SystemDimension
            
            if ColumnCounter >= RowCounter
                
                if ColumnCounter < SystemDimension
                    
                    fprintf(fid, 'Wp%s%s%s, ', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                else
                    
                    if RowCounter == SystemDimension
                        
                        fprintf(fid, 'Wp%s%s%s];\n', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                        
                    else
                        
                        fprintf(fid, 'Wp%s%s%s;\n', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                        
                    end
                    
                end
                
            else
                
                fprintf(fid, 'Wp%s%s%s, ', num2str(AgentsCounter),num2str(ColumnCounter),num2str(RowCounter));
                
            end
            
        end
    end
    
    fprintf(fid, '\n', num2str(AgentsCounter));
    
    % Writes the vector Wc whose elements are the coefficients Wc
    fprintf(fid, 'Wc%s = [', num2str(AgentsCounter));
    for RowCounter = 1:SystemDimension
        
        for ColumnCounter = 1:SystemDimension
            
            if ColumnCounter >= RowCounter
                
                if RowCounter*ColumnCounter < SystemDimension^2
                    
                    fprintf(fid, 'Wc%s%s%s;', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                else
                    
                    fprintf(fid, 'Wc%s%s%s];\n', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                end
                
            end
            
        end
    end
    
    % Writes the vector Wp whose elements are the polynomials Wp
    fprintf(fid, 'Wp%s = [', num2str(AgentsCounter));
    for RowCounter = 1:SystemDimension
        
        for ColumnCounter = 1:SystemDimension
            
            if ColumnCounter >= RowCounter
                
                if RowCounter*ColumnCounter < SystemDimension^2
                    
                    fprintf(fid, 'Wp%s%s%s;', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                else
                    
                    fprintf(fid, 'Wp%s%s%s];\n', num2str(AgentsCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                end
                
            end
            
        end
    end
    
    fprintf(fid, '\n', num2str(AgentsCounter));
    
    % Writes the code to compute DW as the Jacobian of W
    fprintf(fid, '%% Creation of DW%s\n',num2str(AgentsCounter));
    
    fprintf(fid, 'DWTemp = jacobian(Wp%s,q%s);\n',num2str(AgentsCounter),num2str(AgentsCounter));
    
    % Writes the matrix DW whose elements are the elements of the vector DWTemp
    fprintf(fid, 'DW%s = [', num2str(AgentsCounter));
    
    counter = 1;
    for RowCounter = 1:SystemDimension
        
        for ColumnCounter = 1:SystemDimension
            
            if ColumnCounter >= RowCounter
                
                if ColumnCounter == SystemDimension && RowCounter < SystemDimension
                    
                    fprintf(fid, 'DWTemp(%s,:)*f%s;\n', num2str(counter),num2str(AgentsCounter));
                    fprintf(fid,'       ');
                    
                elseif RowCounter == SystemDimension
                    
                    fprintf(fid, 'DWTemp(%s,:)*f%s/2];\n', num2str(counter),num2str(AgentsCounter));
                    
                else
                    
                    if ColumnCounter == RowCounter
                        
                        fprintf(fid, 'DWTemp(%s,:)*f%s/2, ', num2str(counter),num2str(AgentsCounter));
                    
                    else
                        
                        fprintf(fid, 'DWTemp(%s,:)*f%s,   ', num2str(counter),num2str(AgentsCounter));
                        
                    end
                
                end
                

                counter = counter + 1;
            else
                
                fprintf(fid, '0,                ');
                
            end
            
        end
        
        
    end
    
    fprintf(fid, 'DW%s = DW%s + transpose(DW%s);\n', num2str(AgentsCounter),num2str(AgentsCounter),num2str(AgentsCounter));
    fprintf(fid, '\n\n');
end

% Writes W as block-diagonal matrix composed of the Wn's
fprintf(fid, 'W = blkdiag(');
for AgentsCounter = 1:NumberOfAgents
    
    if AgentsCounter < NumberOfAgents
        fprintf(fid, 'W%s,', num2str(AgentsCounter));
    else
        fprintf(fid, 'W%s);\n', num2str(AgentsCounter));
    end
    
end

fprintf(fid, 'WConstraints = [');
for AgentsCounter = 1:NumberOfAgents
    
    if AgentsCounter < NumberOfAgents
        fprintf(fid, 'sos(W%s-eye(%d)*%f);', num2str(AgentsCounter),SystemDimension,ScalingFactor);
    else
        fprintf(fid, 'sos(W%s-eye(%d)*%f)];\n', num2str(AgentsCounter),SystemDimension,ScalingFactor);
    end
    
end

% Writes DW as block-diagonal matrix composed of the DWn's
fprintf(fid, 'DW = blkdiag(');
for AgentsCounter = 1:NumberOfAgents
    
    if AgentsCounter < NumberOfAgents
        fprintf(fid, 'DW%s,', num2str(AgentsCounter));
    else
        fprintf(fid, 'DW%s);\n', num2str(AgentsCounter));
    end
    
end

% Writes Wc a vector obtained by concatenating all Wc's
fprintf(fid, 'Wc = [');
for AgentsCounter = 1:NumberOfAgents
    
    if AgentsCounter < NumberOfAgents
        fprintf(fid, 'Wc%s;', num2str(AgentsCounter));
    else
        fprintf(fid, 'Wc%s];\n', num2str(AgentsCounter));
    end
    
end

fclose(fid);

end