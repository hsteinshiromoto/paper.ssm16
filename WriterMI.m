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


for AgentsCounter = 1:NumberOfAgents - 1
    
    fprintf(fid, 'Block%s = ',num2str(AgentsCounter));
    
    if AgentsCounter == 1
        fprintf(fid, 'MI(1:6,1:6);\n');
        
    else
        fprintf(fid, 'MI(4:9,4:9);\n');
        
    end
    fprintf(fid, 'Block%s(3:end,3:end) = Block%s(3:end,3:end)/2;\n',num2str(AgentsCounter),num2str(AgentsCounter));
    
    fprintf(fid, '\n');
end

fprintf(fid, 'MIConstraints = [');
if NumberOfAgents > 1
    for AgentsCounter = 1:NumberOfAgents-1
        fprintf(fid, 'sos(-Block%s + %f*eye(size(Block%s)));',num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter));
    end
else
    fprintf(fid, 'sos(-MI + %f*eye(size(MI)));',ScalingFactor);
end
    
    
    fprintf(fid, '];');
    


fclose(fid);

end