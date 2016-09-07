%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% File: WriterMI                                                          %
% Git Branch: Master                                                      %
% Author: H. Stein Shiromoto                                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function test
% 
% SystemStates = ['x','y','z'];
% ScalingFactor = 1e-2;
% lambda = 2;
% LaplacianMatrix = LinearLaplacianGenerator(3)
% WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor,lambda)
% 
% end
% 
% function WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor,lambda)

function WriterMI(SystemStates,LaplacianMatrix,ScalingFactor,lambda)

fid = fopen('PreProcessedMI.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

fprintf(fid, 'MI = -DW + A*W + transpose(A*W) - R*B*transpose(B) + 2*%f*W;\n\n',lambda);

    
    for AgentsCounter = 1:NumberOfAgents
        
        fprintf(fid, 'Block%s = ',num2str(AgentsCounter));
        
        if AgentsCounter == 1
            fprintf(fid, 'MI(1:3,1:3);\n');
        elseif AgentsCounter == 2
            fprintf(fid, 'MI(4:6,4:6);\n');
        else
            fprintf(fid, 'MI(7:9,7:9);\n');
        end
        
        fprintf(fid, 'Block%s(3,3) = Block%s(3,3)/2;\n',num2str(AgentsCounter),num2str(AgentsCounter));
        fprintf(fid, '\n');
    end
    
    fprintf(fid, 'MIConstraints = [');
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, 'sos(-Block%s + %f*eye(size(Block%s)));',num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter));
    end
    
    fprintf(fid, '];');
    


fclose(fid);

end