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

fprintf(fid, 'MI = -DW + A*W + transpose(A*W) + R*B*transpose(B) + 2*%f*W;\n\n',lambda);
    
    for AgentsCounter = 1:NumberOfAgents - 1
        fprintf(fid, 'Block%s = ',num2str(AgentsCounter));
        fprintf(fid, 'MI(%s:%s,%s:%s);\n',num2str(NumberOfStates*AgentsCounter - 2),num2str(2*NumberOfStates*AgentsCounter - 2*(AgentsCounter-2)),num2str(NumberOfStates*AgentsCounter - 1),num2str(2*NumberOfStates*AgentsCounter - 2*(AgentsCounter-1)));
        fprintf(fid, 'Block%s(3,3) = Block%s(3,3)/2;\n',num2str(AgentsCounter),num2str(AgentsCounter));
        fprintf(fid, '\n');
    end
    
    fprintf(fid, 'MIConstraints = [');
    for AgentsCounter = 1:NumberOfAgents - 1
        fprintf(fid, 'sos(-Block%s + %f*eye(size(Block%s)));',num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter));
    end
    fprintf(fid, '];');
    


fclose(fid);

end