%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% File: WriterMI                                                          %
% Git Branch: LinearDissipativeInterconnection                            %
% Author: H. Stein Shiromoto                                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function test
% 
% SystemStates = ['x','y','z'];
% lambda = 2;
% LaplacianMatrix = LinearLaplacianGenerator(3)
% WriterMI1(SystemStates,LaplacianMatrix,lambda)
% 
% end

% function WriterMI1(SystemStates,LaplacianMatrix,lambda)

function WriterMI(SystemStates,LaplacianMatrix,lambda)

fid = fopen('PreProcessedMI.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

fprintf(fid, 'MI = -DW + A*W + transpose(A*W) - B*R*transpose(B) + 2*%f*W;\n\n',lambda);



if NumberOfAgents > 1
    
    for AgentCounter = 1:NumberOfAgents - 1
        
        fprintf(fid, 'block%d = ',AgentCounter);
        if AgentCounter == 1
            fprintf(fid, '-MI(%d:%d,%d:%d);\n ',AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*2*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*2*NumberOfStates);
        else
            fprintf(fid, '-MI(%d:%d,%d:%d);\n ',AgentCounter*NumberOfStates - (NumberOfStates - 1),(AgentCounter + 1)*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),(AgentCounter + 1)*NumberOfStates);
        end
        fprintf(fid, 'block%d(4:6,4:6) = block%d(4:6,4:6)/2; \n\n',AgentCounter,AgentCounter);
    end
    fprintf(fid, 'MIConstraints = [');
    for AgentCounter = 1:NumberOfAgents - 1
        fprintf(fid, 'sos(block%d);',AgentCounter);
    end

    fprintf(fid, '];\n\n');

    
else
    fprintf(fid, 'MIConstraints = [sos(-MI)];\n');
end


fclose(fid);

end