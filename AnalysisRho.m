%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% File: AnalysisRho                                                       %
% Git Branch: Master                                                      %
% Author: H. Stein Shiromoto                                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function AnalysisRho(SystemStates,LaplacianMatrix,Precision)

fid = fopen('PostProcessedRho.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

for AgentCounter = 1:NumberOfAgents
        fprintf(fid, 'VerifiedRho%s = ', num2str(AgentCounter));
        fprintf(fid, 'clean(replace(Rho%s), coefList, double(coefList)), %s);\n', num2str(AgentCounter),num2str(Precision));
        fprintf(fid, 'Rho%s = ', num2str(AgentCounter));
        fprintf(fid, 'sdisplay(VerifiedRho%s);\n\n', num2str(AgentCounter));
        fprintf(fid, 'clear VerifiedRho%s;\n', num2str(AgentCounter));
end

fprintf(fid, 'R = blkdiag(');

for AgentCounter = 1:NumberOfAgents
    
    fprintf(fid, 'Rho%s*eye(%d)', num2str(AgentCounter),NumberOfStates);
    
    if AgentCounter == NumberOfAgents
        fprintf(fid, ');');
    else
        fprintf(fid, '; ');
    end
    
end

fclose(fid);

end