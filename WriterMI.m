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

fprintf(fid, 'MIConstraints = [');
    for AgentsCounter = 1:NumberOfAgents
        
        fprintf(fid, 'sos(-MI(%s,%s) + %f*eye(size(MI(%s,%s))))',num2str(AgentsCounter),num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter),num2str(AgentsCounter));
        
        if AgentsCounter == 1
            
            fprintf(fid, '; sos(MI(%s,%s) - MI(%s,%s + 1))',num2str(AgentsCounter),num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter),num2str(AgentsCounter));
            
        elseif AgentsCounter == NumberOfAgents
            
            fprintf(fid, '; sos(MI(%s,%s) - MI(%s,%s - 1))',num2str(AgentsCounter),num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter),num2str(AgentsCounter));
            
        else
            
            fprintf(fid, '; sos(MI(%s,%s) - MI(%s,%s - 1))',num2str(AgentsCounter),num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter),num2str(AgentsCounter));
            fprintf(fid, '; sos(MI(%s,%s) - MI(%s,%s + 1))',num2str(AgentsCounter),num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter),num2str(AgentsCounter));
            
        end
    end


fprintf(fid, '];');
    


fclose(fid);

end