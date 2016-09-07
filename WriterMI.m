%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% File: WriterMI                                                          %
% Git Branch: Master                                                      %
% Author: H. Stein Shiromoto                                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function test

SystemStates = ['x','y','z'];
ScalingFactor = 1e-2;
lambda = 2;
LaplacianMatrix = LinearLaplacianGenerator(3)
WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor,lambda)

end

function WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor,lambda)

% function WriterMI(SystemStates,LaplacianMatrix,ScalingFactor,lambda)

fid = fopen('PreProcessedMI.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

fprintf(fid, 'MI = -DW + A*W + transpose(A*W) - R*B*transpose(B) + 2*%f*W;\n\n',lambda);

fprintf(fid, 'MIConstraints = [');


for AgentCounter = 1:NumberOfAgents


            fprintf(fid, 'sos(-MI(%d:%d,%d:%d) + %f*eye(size(MI(%d:%d,%d:%d)))); ',AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,ScalingFactor,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates);

            if AgentCounter == 1
                fprintf(fid, 'sos(MI(%d:%d,%d:%d) - MI(%d:%d,%d:%d)); ',AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates + 1,AgentCounter*NumberOfStates + NumberOfStates);
            elseif AgentCounter == NumberOfAgents
                fprintf(fid, 'sos(MI(%d:%d,%d:%d) - MI(%d:%d,%d:%d)); ',AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,(AgentCounter - 1)*NumberOfStates - (NumberOfStates - 1),(AgentCounter - 1)*NumberOfStates);
            else
                fprintf(fid, 'sos(MI(%d:%d,%d:%d) - MI(%d:%d,%d:%d)); ',AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates + 1,AgentCounter*NumberOfStates + NumberOfStates);
                fprintf(fid, 'sos(MI(%d:%d,%d:%d) - MI(%d:%d,%d:%d)); ',AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,AgentCounter*NumberOfStates - (NumberOfStates - 1),AgentCounter*NumberOfStates,(AgentCounter - 1)*NumberOfStates - (NumberOfStates - 1),(AgentCounter - 1)*NumberOfStates);
            end
        
end

fprintf(fid, '];\n\n');

fclose(fid);

end