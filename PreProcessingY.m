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

% Note: Works only for Linear Graphs!
 
% function test
% 
% L = eye(5);
% NAgents = size(L,1);
% Option = 'Neighbor';
% PreProcessingY1(2*NAgents,L,Option)
% 
% end

function PreProcessingY(LinesVectorB,L,Option)

fid = fopen('PreProcessedY.m','w');

NAgents = size(L,1);
LinesVectorBi = LinesVectorB/NAgents; % Number of lines of each vector Bi

for RowCounter = 1:NAgents
    
    fprintf(fid, '\n %% Creation of Variable Y%s\n\n',num2str(RowCounter));
    
    for ColumnCounter = 1:LinesVectorB
        
        % size(B') variables
        if strcmp(Option,'General') 
            
            fprintf(fid, '[Y%s%s,Yc%s%s,Yv%s%s] = polynomial(',  num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
            fprintf(fid, 'q,');
            fprintf(fid, 'Ydegree,0);\n');
        
        % Each variable Y depends on the system i and its neighbor
        elseif strcmp(Option,'Neighbor')
                
                if RowCounter > 1 && RowCounter < NAgents
                    
                    if ColumnCounter >= (RowCounter - 1)*LinesVectorBi -1 && ColumnCounter <= (RowCounter - 1)*LinesVectorBi + 4
                        
                        fprintf(fid, '[Y%s%s,Yc%s%s,Yv%s%s] = polynomial(',  num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                        fprintf(fid, '[q%s;q%s;q%s],',num2str(RowCounter-1),num2str(RowCounter),num2str(RowCounter+1));
                        fprintf(fid, 'Ydegree,0);\n');
                        
                    end
                    
                elseif RowCounter == 1 && ColumnCounter <= 2*LinesVectorBi
                    
                    fprintf(fid, '[Y%s%s,Yc%s%s,Yv%s%s] = polynomial(',  num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                    fprintf(fid, '[q%s;q%s],',num2str(RowCounter),num2str(RowCounter + 1));
                    fprintf(fid, 'Ydegree,0);\n');
                    
                else
                    
                    if  RowCounter == NAgents && ColumnCounter > LinesVectorB - 2*LinesVectorBi
                        fprintf(fid, '[Y%s%s,Yc%s%s,Yv%s%s] = polynomial(',  num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                        fprintf(fid, '[q%s;q%s],',num2str(RowCounter - 1),num2str(RowCounter));
                        fprintf(fid, 'Ydegree,0);\n');
                    end
                    
                end
                    
            
                
        else
            
            % Each variable Y depends on the system i
            if strcmp(Option,'Decentralized')
                
                if RowCounter == 1 && ColumnCounter <= LinesVectorBi
                    
                    fprintf(fid, '[Y%s%s,Yc%s%s,Yv%s%s] = polynomial(',  num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                    fprintf(fid, 'q%s,Ydegree,0);\n',num2str(RowCounter));
                    
                elseif RowCounter > 1 && ColumnCounter > (RowCounter - 1)*LinesVectorBi && ColumnCounter <= RowCounter*LinesVectorBi
                    
                    fprintf(fid, '[Y%s%s,Yc%s%s,Yv%s%s] = polynomial(',  num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                    fprintf(fid, 'q%s,Ydegree,0);\n',num2str(RowCounter));
                                        
                end
                
            end
            
        end
        
        
        
    end
    
    
end

fprintf(fid, '\n %% Creation of Vector Yc\n\n');

fprintf(fid, '\n');
fprintf(fid, 'Yc = [');
for RowCounter = 1:NAgents
    
    for ColumnCounter = 1:LinesVectorB
        
        if strcmp(Option,'General')
            
            fprintf(fid, 'Yc%s%s',num2str(RowCounter),num2str(ColumnCounter));
            
            if ColumnCounter == LinesVectorB && RowCounter == NAgents
                
                fprintf(fid, '];');
                
            else
                
                fprintf(fid, '; ');
                
            end
            
        elseif strcmp(Option,'Neighbor')
            
            if RowCounter > 1 && RowCounter < NAgents
                
                    if ColumnCounter >= (RowCounter - 1)*LinesVectorBi -1 && ColumnCounter <= (RowCounter - 1)*LinesVectorBi + 4
                    
                        fprintf(fid, 'Yc%s%s; ',  num2str(RowCounter),num2str(ColumnCounter));
                    
                    end
                    
                elseif RowCounter == 1 && ColumnCounter <= 2*LinesVectorBi
                    
                    fprintf(fid, 'Yc%s%s; ',  num2str(RowCounter),num2str(ColumnCounter));
                    
                else
                    
                    if  RowCounter == NAgents && ColumnCounter > LinesVectorB - 2*LinesVectorBi
                        
                        fprintf(fid, 'Yc%s%s',  num2str(RowCounter),num2str(ColumnCounter));
                        
                        if ColumnCounter == LinesVectorB
                            
                            fprintf(fid, '];');
                            
                        else
                            
                            fprintf(fid, '; ');
                            
                        end
                        
                    end
                    
            end
            
        else
            
            if strcmp(Option,'Decentralized')
                
                if RowCounter == 1 && ColumnCounter <= LinesVectorBi
                    
                    fprintf(fid, 'Yc%s%s; ',num2str(RowCounter),num2str(ColumnCounter));
                    
                elseif RowCounter > 1 && ColumnCounter > (RowCounter - 1)*LinesVectorBi && ColumnCounter <= RowCounter*LinesVectorBi
                    
                    fprintf(fid, 'Yc%s%s',num2str(RowCounter),num2str(ColumnCounter));
                    
                    if RowCounter == NAgents && ColumnCounter == LinesVectorB
                        
                        fprintf(fid, '];');
                        
                    else
                        
                        fprintf(fid, '; ');
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

fprintf(fid, '\n %% Creation of Matrix Y\n\n');

fprintf(fid, '\n');
fprintf(fid, 'Y = [');
for RowCounter = 1:NAgents
    
    if RowCounter > 1
        
        fprintf(fid,'     ');
    end
    
    for ColumnCounter = 1:LinesVectorB
        
        if strcmp(Option,'General') 
            
            fprintf(fid, 'Y%s%s',num2str(RowCounter),num2str(ColumnCounter));
            
        elseif strcmp(Option,'Neighbor')
            
            if L(RowCounter,ceil(ColumnCounter/LinesVectorBi)) ~= 0
                
                fprintf(fid, 'Y%s%s',num2str(RowCounter),num2str(ColumnCounter));
                
            else
                
                fprintf(fid, '0  ');
                
            end
            
        else
            
            if strcmp(Option,'Decentralized')
                
                if RowCounter == 1 && ColumnCounter <= LinesVectorBi
                    
                    fprintf(fid, 'Y%s%s',num2str(RowCounter),num2str(ColumnCounter));
                    
                elseif RowCounter > 1 
                    
                    if ColumnCounter > (RowCounter - 1)*LinesVectorBi && ColumnCounter <= RowCounter*LinesVectorBi
                        
                        fprintf(fid, 'Y%s%s',num2str(RowCounter),num2str(ColumnCounter));
                        
                    else
                        
                        fprintf(fid, '0  ');
                        
                    end
                    
                else
                    
                    fprintf(fid, '0  ');
                    
                end
                
            end
            
        end
        
        if ColumnCounter < LinesVectorB
            
            fprintf(fid, ', ');
            
        else
            
            if RowCounter == NAgents
                
                 fprintf(fid, '];\n');
            
            else
                
                fprintf(fid, ';\n');
                
            end
            
        end
        
    end
    
end

fclose(fid);

end