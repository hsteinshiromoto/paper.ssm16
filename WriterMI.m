% function test
% 
% SystemStates = ['x','y'];
% ScalingFactor = 1e-2;
% LaplacianMatrix = LinearLaplacianGenerator(5)
% WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor)
% 
% end
% 
% function WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor)

function WriterMI(SystemStates,LaplacianMatrix,ScalingFactor,lambda,Option)

fid = fopen('PreProcessedMI.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

% for AgentsCounter = 1:NumberOfAgents
%     
%     for NeighborCounter = 1:NumberOfAgents
%             
%             if LaplacianMatrix(AgentsCounter,NeighborCounter) ~= 0
%                 
%                 fprintf(fid, 'Component%s%s = A%s%s*W%s + transpose(A%s%s*W%s) + ',num2str(AgentsCounter),num2str(NeighborCounter),num2str(AgentsCounter),num2str(NeighborCounter),num2str(NeighborCounter),num2str(NeighborCounter),num2str(AgentsCounter),num2str(AgentsCounter));
%                 fprintf(fid, 'B%s*Y%s%s + transpose(B%s*Y%s%s);\n',num2str(AgentsCounter),num2str(AgentsCounter),num2str(NeighborCounter),num2str(NeighborCounter),num2str(NeighborCounter),num2str(AgentsCounter));
%                 
%             else
%                 
%                 fprintf(fid, 'Component%s%s = %d;\n',num2str(AgentsCounter),num2str(NeighborCounter),0);
%                 
%             end
%         
%     end
%     fprintf(fid, '\n');
% end

fprintf(fid, 'MI = -DW + A*W + transpose(A*W) + B*Y + transpose(B*Y) + 2*%f*W;\n\n',lambda);

if strcmp(Option,'Diagonal') || strcmp(Option,'Neighbor')
    
    for AgentsCounter = 1:NumberOfAgents - 1
        fprintf(fid, 'Block%s = ',num2str(AgentsCounter));
        fprintf(fid, 'MI(%s:%s,%s:%s);\n',num2str(NumberOfStates*AgentsCounter - 1),num2str(2*NumberOfStates*AgentsCounter - 2*(AgentsCounter-1)),num2str(NumberOfStates*AgentsCounter - 1),num2str(2*NumberOfStates*AgentsCounter - 2*(AgentsCounter-1)));
        fprintf(fid, 'Block%s(2,2) = Block%s(2,2)/2;\n',num2str(AgentsCounter),num2str(AgentsCounter));
        fprintf(fid, '\n');
    end
    
    fprintf(fid, 'MIConstraints = [');
    for AgentsCounter = 1:NumberOfAgents - 1
        fprintf(fid, 'sos(-Block%s + %f*eye(size(Block%s)));',num2str(AgentsCounter),ScalingFactor,num2str(AgentsCounter));
    end
    fprintf(fid, '];');
    
else
    
    fprintf(fid, 'MIConstraints = sos(-MI + %f*eye(size(MI)));\n',ScalingFactor);
    
end

fclose(fid);

end