%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% File: LMIOptimisation                                                   %
% Git Branch: master                                                      %
% Author: H. Stein Shiromoto                                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function caller
clear all
close all
clc
warning off

NumberOfAgents = 3
LaplacianMatrix = LinearLaplacianGenerator(NumberOfAgents);
LMIOptimisation

end

function LMIOptimisation

PreProcessedSys
PreProcessedW
PreProcessedRho
PreProcessedMI

Constraints = [WConstraints;MIConstraints];
checkset(Constraints)
coefList = [Wc;Rhoc];
options = sdpsettings('solver','mosek','verbose',1);
[sol, q, Q, res] = solvesos(Constraints,[],options,coefList);

PostProcessedW
PostProcessedRho

fname = sprintf('Output');
save(fname)
end